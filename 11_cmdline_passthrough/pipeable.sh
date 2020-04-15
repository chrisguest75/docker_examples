#!/bin/sh

while IFS="" read -r line
do
  # shellcheck disable=SC2053
  echo "[PIPED] ${line}"
done
