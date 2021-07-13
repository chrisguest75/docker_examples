#!/usr/bin/env bash

SCANTYPE=docker
SCAN_FOLDER=./scans/$SCANTYPE

if [[ $CLUSTER == "" ]]; then 
  CLUSTER=$(basename $(kubectl config current-context))
fi

FILES="$SCAN_FOLDER/*"
for f in $FILES
do
  TMP_FRAGMENT_FILE=$(mktemp)
  jq '[ .vulnerabilities[] | {key:.severity | ascii_downcase, value:.identifiers["CVE"][]} ] | map([.] | from_entries) | reduce .[] as $o ({}; reduce ($o|keys)[] as $key (.; .[$key] += [$o[$key]] )) | {CVE:.}' $f > "$TMP_FRAGMENT_FILE"
  TMP_IMAGE_FILE=$(mktemp)
  jq --arg cluster "$CLUSTER"  -c '{ "cluster": $cluster, "issues":(.vulnerabilities | group_by(.severity) | map({"severity":.[0].severity, "count":length})), "image":.path, "inputfile":input_filename, "error": (if .error == null then "" else .error end)}' $f > "$TMP_IMAGE_FILE"
  jq -c -s '.[0] + { "CVE":.[1].CVE}' "$TMP_IMAGE_FILE" "$TMP_FRAGMENT_FILE" 
done
