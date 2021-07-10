#!/usr/bin/env bash

SCANTYPE=trivy
SCAN_FOLDER=./scans/$SCANTYPE

if [[ $CLUSTER == "" ]]; then 
  CLUSTER=$(basename $(kubectl config current-context))
fi

FILES="$SCAN_FOLDER/*"
for f in $FILES
do
  jq --arg cluster "$CLUSTER"  -c '{ "cluster": $cluster, "issues":(.[].Vulnerabilities | group_by(.Severity) | map({"severity":.[0].Severity, "count":length})), "image":.[].imagepath, "namespace":.[].namespace, "inputfile":input_filename, "error": (if .[].error == null then "" else .[].error end)}' $f
done

