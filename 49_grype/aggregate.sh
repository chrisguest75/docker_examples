#!/usr/bin/env bash

SCANTYPE=grype
SCAN_FOLDER=./scans/$SCANTYPE

if [[ $CLUSTER == "" ]]; then 
  CLUSTER=$(basename $(kubectl config current-context))
fi

FILES="$SCAN_FOLDER/*"
for f in $FILES
do
  jq --arg cluster "$CLUSTER" -c '{ "cluster": $cluster, "issues":(.matches | group_by(.vulnerability.severity) | map({"severity":.[0].vulnerability.severity, "count":length})), "image":.source.target.userInput, "namespace":.namespace, "inputfile":input_filename, "error": (if .error == null then "" else .error end)}' $f
done
