#!/usr/bin/env bash 
#export DEBUG_BATS=true
set -e
bats -t ./test/shellcheck_tests.bats
bats -t ./test/process_tests.bats
bats -t ./test/legal_branch_name_tests.bats
