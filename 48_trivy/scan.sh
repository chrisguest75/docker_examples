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

SCANTYPE=trivy
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
      # Trivy Scan
      # ************************************************
      echo -e "Performing the scan: $IMAGE"
      TRIVYOUT=$(trivy -f json -o "$SCAN_FOLDER/$OUTPUT.json" $IMAGE)
      EXITCODE=$?

      echo "$TRIVYOUT" | grep "vulnerability detection may be insufficient because security updates"
      if [[ $? == 0 ]]; then
          # we have detected a known error - merge in extra fields. 
          TMPFILE=$(mktemp)
          jq --arg imagepath "$IMAGE" --arg error "The vulnerability detection may be insufficient because security updates are not provided" '[ .[] + {imagepath: $imagepath, error: $error, Vulnerabilities: []} ]' "$SCAN_FOLDER/$OUTPUT.json" > "$TMPFILE"
          cp "$TMPFILE" "$SCAN_FOLDER/$OUTPUT.json"
          EXITCODE=1
      else
          # NO ERROR DETECTED in output 
          # add imagepath field 
          TMPFILE=$(mktemp)
          jq --arg imagepath "$IMAGE" '[ .[] + {imagepath: $imagepath} ]' "$SCAN_FOLDER/$OUTPUT.json" > "$TMPFILE"
          cp "$TMPFILE" "$SCAN_FOLDER/$OUTPUT.json"

          # adding Vulnerabilities field if it doesn't exist
          ERROR=$(jq '.[].Vulnerabilities' "$SCAN_FOLDER/$OUTPUT.json")
          if [[ $ERROR == "null" ]]; then
            TMPFILE=$(mktemp)
            jq --arg imagepath "$IMAGE" '[ .[] + { Vulnerabilities: []} ]' "$SCAN_FOLDER/$OUTPUT.json" > "$TMPFILE"
            cp "$TMPFILE" "$SCAN_FOLDER/$OUTPUT.json"
          fi

          EXITCODE=$EXITCODE
      fi
    else  
      echo "Skipping $SCAN_FOLDER/$OUTPUT.json already exists - delete file to recreate"
    fi

    # if we had an error scanning work out what it was.
    if [[ $EXITCODE != 0 ]]; then
      if [[ -f "$SCAN_FOLDER/$OUTPUT.json" ]]; then
        ERROR=$(jq .[].error "$SCAN_FOLDER/$OUTPUT.json")
        if [[ $ERROR != "null" ]]; then
          echo -e "Error scanning image: '$IMAGE' - '$ERROR'"
          #exit 2
        fi
      else
          echo -e "Error scanning image: '$IMAGE' - no generated '$SCAN_FOLDER/$OUTPUT.json'"
      fi
    fi
done < <(jq -r '.images[].imagepath' ./images_to_scan.json)

echo "Process the results './scans/out/images_trivy.json'"
if [[ ! -d ./scans/out ]]; then
  mkdir -p ./scans/out
fi 
./aggregate.sh | jq -s '{images: (.)}' > ./scans/out/images_trivy.json  







