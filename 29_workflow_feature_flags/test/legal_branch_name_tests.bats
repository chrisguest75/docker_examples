#!/usr/bin/env bats
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup() {
    if [[ -n $DEBUG_BATS ]]; then    
        INDEX=$((${BATS_TEST_NUMBER} - 1))
        echo "##### setup start" >&3 
        echo "BATS_TEST_NAME:        ${BATS_TEST_NAME}" >&3 
        echo "BATS_TEST_FILENAME:    ${BATS_TEST_FILENAME}" >&3 
        echo "BATS_TEST_DIRNAME:     ${BATS_TEST_DIRNAME}" >&3 
        echo "BATS_TEST_NAMES:       ${BATS_TEST_NAMES[$INDEX]}" >&3 
        echo "BATS_TEST_DESCRIPTION: ${BATS_TEST_DESCRIPTION}" >&3 
        echo "BATS_TEST_NUMBER:      ${BATS_TEST_NUMBER}" >&3 
        echo "BATS_TMPDIR:           ${BATS_TMPDIR}" >&3 
        echo "##### setup end" >&3 
    fi
    export PATH=$(pwd)/:$PATH    
}

teardown() {
    if [[ -n $DEBUG_BATS ]]; then
        echo -e "##### teardown ${BATS_TEST_NAME}\n" >&3 
    fi
}

#*******************************************************************
#* 
#*******************************************************************

@test "No branch or parameter" {
    run legal_branch_name 
    #echo $output >&3 
    assert_line --index 0 --regexp '^BRANCH not set and no parameter passed'
    assert_failure
}

@test "Parameter has precdence" {
    local BRANCH=5master
    run legal_branch_name parameter 
    #echo $output >&3 
    assert_line --index 0 --regexp '^parameter is legal'
    assert_success
}
