#!/usr/bin/env bash

SCANTYPE=trivy
SCAN_FOLDER=./scans/$SCANTYPE

if [[ $CLUSTER == "" ]]; then 
  CLUSTER=$(basename $(kubectl config current-context))
fi

FILES="$SCAN_FOLDER/*"
for f in $FILES
do
  TMP_FRAGMENT_FILE=$(mktemp)
  #echo $TMP_FRAGMENT_FILE
  jq '[ .[].Vulnerabilities[] | {"key":.Severity | ascii_downcase, "value":.VulnerabilityID} ] | map([.] | from_entries) | reduce .[] as $o ({}; reduce ($o|keys)[] as $key (.; .[$key] += [$o[$key]] )) | {low:(.low + []) | sort | unique, high:(.high + []) | sort | unique, critical:(.critical + []) | sort | unique, medium:(.medium + []) | sort | unique } | {CVE:.}' $f > "$TMP_FRAGMENT_FILE"

  TMP_PACKAGES_FILE=$(mktemp)
  #echo $TMP_PACKAGES_FILE
  jq '[ .[].Vulnerabilities[] | {"key":.VulnerabilityID, "value":.PkgName} ] | map([.] | from_entries) | reduce .[] as $o ({}; reduce ($o|keys)[] as $key (.; .[$key] += [$o[$key]] )) | {packages:.}' $f > "$TMP_PACKAGES_FILE"

  TMP_IMAGE_FILE=$(mktemp)
  #echo $TMP_IMAGE_FILE
  jq --arg cluster "$CLUSTER"  -c '{ "cluster": $cluster, "issues":(.[].Vulnerabilities | group_by(.Severity) | map({"severity":.[0].Severity | ascii_downcase, "count":length})), "image":.[].imagepath, "namespace":.[].namespace, "inputfile":input_filename, "error": (if .[].error == null then "" else .[].error end)}' $f  > "$TMP_IMAGE_FILE"

  jq -c -s '.[0] + { "CVE":.[1].CVE, "packages":.[2].packages}' "$TMP_IMAGE_FILE" "$TMP_FRAGMENT_FILE" "$TMP_PACKAGES_FILE"
done
