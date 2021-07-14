#!/usr/bin/env bash

SCANTYPE=grype
SCAN_FOLDER=./scans/$SCANTYPE

if [[ $CLUSTER == "" ]]; then 
  CLUSTER=$(basename $(kubectl config current-context))
fi

FILES="$SCAN_FOLDER/*"
for f in $FILES
do
  TMP_FRAGMENT_FILE=$(mktemp)
  #echo $TMP_FRAGMENT_FILE
  jq '[ .matches[].vulnerability | {"key":.severity | ascii_downcase, "value":.id} ] | map([.] | from_entries) | reduce .[] as $o ({}; reduce ($o|keys)[] as $key (.; .[$key] += [$o[$key]] )) | {low:(.negligible + .low + []) | sort | unique, high:(.high + .unknown + []) | sort | unique, critical:(.critical + []) | sort | unique, medium:(.medium + []) | sort | unique } | {CVE:.}' $f > "$TMP_FRAGMENT_FILE"

  TMP_PACKAGES_FILE=$(mktemp)
  #echo $TMP_PACKAGES_FILE
  jq '[ .matches[] | {"key":.vulnerability.id, "value":.artifact.name} ] | map([.] | from_entries) | reduce .[] as $o ({}; reduce ($o|keys)[] as $key (.; .[$key] += [$o[$key]] )) | {packages:.}' $f > "$TMP_PACKAGES_FILE"

  TMP_IMAGE_FILE=$(mktemp)
  #echo $TMP_IMAGE_FILE
  jq --arg cluster "$CLUSTER" -c '{ "cluster": $cluster, "issues":(.matches | group_by(.vulnerability.severity) | map({"severity":.[0].vulnerability.severity, "count":length})), "image":.source.target.userInput, "namespace":.namespace, "inputfile":input_filename, "error": (if .error == null then "" else .error end)}' $f > "$TMP_IMAGE_FILE"

  jq -c -s '.[0] + { "CVE":.[1].CVE, "packages":.[2].packages}' "$TMP_IMAGE_FILE" "$TMP_FRAGMENT_FILE" "$TMP_PACKAGES_FILE"
done

