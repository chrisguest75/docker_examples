#!/usr/bin/env bash

function check_prerequisites() {
    for i in "$@"
    do
        local dependency=$i

        if [[ ! $(command -v "$dependency") ]]; then
            echo "$dependency is not-installed"
            exit 0
        fi
    done
}

SCANTYPE=grype
echo "Checking $SCANTYPE"
check_prerequisites $SCANTYPE

# create folder to store the json outputs
SCAN_FOLDER=./scans/$SCANTYPE
if [[ ! -d $SCAN_FOLDER ]]; then
  mkdir -p $SCAN_FOLDER
fi 

while read -r IMAGE
do
    OUTPUT=$(basename $IMAGE)
    OUTPUT=$(echo $OUTPUT | sed 's/:/_/g') 
    EXITCODE=0
    if [[ ! -f "$SCAN_FOLDER/$OUTPUT.json" ]]; then 
      # ************************************************
      # Grype Scan
      # ************************************************
      echo -e "Performing the scan: $IMAGE"

      # *** TODO: Including grype this here quits the loop after 1 iteration ***
      GRYPEOUT=$(grype -o json $IMAGE > "$SCAN_FOLDER/$OUTPUT.json")
      EXITCODE=$?

      echo "$GRYPEOUT" | grep "failed to catalog: could not fetch image"
      if [[ $? == 0 ]]; then
          TMPFILE=$(mktemp)
          # scan will be empty file
          echo '{}' | jq --arg imagepath "$IMAGE" --arg error "failed to catalog: could not fetch image" '[ . + {imagepath: $imagepath, error: $error, "matches": []} ]' > "$TMPFILE"
          cp "$TMPFILE" "$SCAN_FOLDER/$OUTPUT.json"
          EXITCODE=1
      else
          # NO ERROR DETECTED in output 
          # add imagepath field 
          TMPFILE=$(mktemp)
          jq --arg imagepath "$IMAGE" '. + {imagepath: $imagepath}' "$SCAN_FOLDER/$OUTPUT.json" > "$TMPFILE"
          cp "$TMPFILE" "$SCAN_FOLDER/$OUTPUT.json"

          EXITCODE=$EXITCODE
      fi

    else  
      echo "Skipping $SCAN_FOLDER/$OUTPUT.json already exists - delete file to recreate"
    fi

    echo "EXITCODE=$EXITCODE"
    # if we had an error scanning work out what it was.
    if [[ $EXITCODE != 0 ]]; then
      if [[ -f "$SCAN_FOLDER/$OUTPUT.json" ]]; then
        ERROR=$(jq .error "$SCAN_FOLDER/$OUTPUT.json")
        if [[ $ERROR != "null" ]]; then
          echo -e "Error scanning image: '$IMAGE' - '$ERROR'"
          #exit 2
        fi
      else
          echo -e "Error scanning image: '$IMAGE' - no generated '$SCAN_FOLDER/$OUTPUT.json'"
      fi
    fi
done < <(jq -r '.images[].imagepath' ./images_to_scan.json)  


echo "Process the results './scans/out/images_grype.json'"
if [[ ! -d ./scans/out ]]; then
  mkdir -p ./scans/out
fi 
./aggregate.sh | jq -s '{images: (.)}' > ./scans/out/images_grype.json  







