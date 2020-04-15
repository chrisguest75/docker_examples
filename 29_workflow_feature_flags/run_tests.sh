#!/usr/bin/env bash 

set -e
bats -t ./test/process_tests.bats
bats -t ./test/legal_branch_name_tests.bats
