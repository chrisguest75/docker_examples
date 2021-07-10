#!/usr/bin/env bash

SCANTYPE=grype

# create folder to store the json outputs
SCAN_FOLDER=./scans/$SCANTYPE
if [[ ! -d $SCAN_FOLDER ]]; then
  mkdir -p $SCAN_FOLDER
fi 

IMAGES=$(jq -r '.images[].imagepath' ./images_to_scan.json)
while IFS=' ', read -r IMAGE
do

    OUTPUT=$(basename $IMAGE)
    OUTPUT=$(echo $OUTPUT | sed 's/:/_/g') 
    EXITCODE=0
    if [[ ! -f "$SCAN_FOLDER/$OUTPUT.json" ]]; then 
      # ************************************************
      # Grype Scan
      # ************************************************
      echo -e "Performing the scan: $IMAGE"
      grype -o json $IMAGE > "$SCAN_FOLDER/$OUTPUT.json"
      EXITCODE=$?
    else  
      echo "Skipping $SCAN_FOLDER/$OUTPUT.json already exists - delete file to recreate"
    fi

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
done <<< "$IMAGES"


echo "Process the results './scans/out/images_grype.json'"
if [[ ! -d ./scans/out ]]; then
  mkdir -p ./scans/out
fi 
./aggregate.sh | jq -s '{images: (.)}' > ./scans/out/images_grype.json  







