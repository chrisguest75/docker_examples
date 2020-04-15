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

@test "No branch or commit prints out empty variables" {
    run process 
    #echo $output >&3 
    assert_line --index 0 --regexp '^# BRANCH is set to'
    assert_line --index 1 --regexp '^# COMMIT_SHA1 is set to'
    assert_success
}

@test "Specific BRANCH prints out selected variables" {
    export master_FORCE_TEST_FAIL=true
    export BRANCH=master
    run process 
    #echo $output >&3 
    assert_line --index 0 --regexp '^# BRANCH is set to master'
    assert_line --index 1 --regexp '^# COMMIT_SHA1 is set to'
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL=true'
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL="true"'
    assert_success
}

@test "Specific COMMIT_SHA1 prints out selected variables" {
    export fb93e86f557c95d86e5dfc84973661183be8c5fa_SKIP_TESTS=true
    export COMMIT_SHA1=fb93e86f557c95d86e5dfc84973661183be8c5fa
    run process 
    #echo $output >&3 
    assert_line --index 0 --regexp '^# BRANCH is set to'
    assert_line --index 1 --regexp '^# COMMIT_SHA1 is set to fb93e86f557c95d86e5dfc84973661183be8c5fa'
    assert_line --index 2 --regexp '^# FROM fb93e86f557c95d86e5dfc84973661183be8c5fa_SKIP_TESTS=true'
    assert_line --index 3 --regexp '^export SKIP_TESTS="true"'
    assert_success
}

@test "Specific BRANCH and COMMIT_SHA1 prints out selected variables" {
    export master_FORCE_TEST_FAIL=true
    export BRANCH=master
    export fb93e86f557c95d86e5dfc84973661183be8c5fa_SKIP_TESTS=true
    export COMMIT_SHA1=fb93e86f557c95d86e5dfc84973661183be8c5fa
    run process 
    #echo $output >&3 
    assert_line --index 0 --regexp '^# BRANCH is set to master'
    assert_line --index 1 --regexp '^# COMMIT_SHA1 is set to fb93e86f557c95d86e5dfc84973661183be8c5fa'
    assert_output --regexp '# FROM master_FORCE_TEST_FAIL=true'
    assert_output --regexp 'export FORCE_TEST_FAIL="true"'    
    assert_output --regexp '# FROM fb93e86f557c95d86e5dfc84973661183be8c5fa_SKIP_TESTS=true'
    assert_output --regexp 'export SKIP_TESTS="true"'
    assert_success
}

@test "Stdin no branch or commit prints out empty variables" {
    run cat <(env | process --stdin)
    #echo $output >&3 
    assert_line --index 0 --regexp '^# BRANCH is set to'
    assert_line --index 1 --regexp '^# COMMIT_SHA1 is set to'
    assert_success
}

@test "Stdin specific BRANCH prints out selected variables" {
    export master_FORCE_TEST_FAIL=true
    export BRANCH=master
    run cat <(env | process --stdin)
    #echo $output >&3 
    assert_line --index 0 --regexp '^# BRANCH is set to master'
    assert_line --index 1 --regexp '^# COMMIT_SHA1 is set to'
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL=true'
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL="true"'
    assert_success
}

@test "Stdin specific COMMIT_SHA1 prints out selected variables" {
    export fb93e86f557c95d86e5dfc84973661183be8c5fa_SKIP_TESTS=true
    export COMMIT_SHA1=fb93e86f557c95d86e5dfc84973661183be8c5fa
    run cat <(env | process --stdin)
    #echo $output >&3 
    assert_line --index 0 --regexp '^# BRANCH is set to'
    assert_line --index 1 --regexp '^# COMMIT_SHA1 is set to fb93e86f557c95d86e5dfc84973661183be8c5fa'
    assert_line --index 2 --regexp '^# FROM fb93e86f557c95d86e5dfc84973661183be8c5fa_SKIP_TESTS=true'
    assert_line --index 3 --regexp '^export SKIP_TESTS="true"'
    assert_success
}

@test "Stdin specific BRANCH and COMMIT_SHA1 prints out selected variables" {
    export master_FORCE_TEST_FAIL=true
    export BRANCH=master
    export fb93e86f557c95d86e5dfc84973661183be8c5fa_SKIP_TESTS=true
    export COMMIT_SHA1=fb93e86f557c95d86e5dfc84973661183be8c5fa
    run cat <(env | process --stdin)
    #echo $output >&3 
    assert_line --index 0 --regexp '^# BRANCH is set to master'
    assert_line --index 1 --regexp '^# COMMIT_SHA1 is set to fb93e86f557c95d86e5dfc84973661183be8c5fa'
    assert_output --regexp '# FROM master_FORCE_TEST_FAIL=true'
    assert_output --regexp 'export FORCE_TEST_FAIL="true"'    
    assert_output --regexp '# FROM fb93e86f557c95d86e5dfc84973661183be8c5fa_SKIP_TESTS=true'
    assert_output --regexp 'export SKIP_TESTS="true"'
    assert_success
}

#*******************************************************************
#* Legal variable names work correctly
#*******************************************************************

@test "Trailing underscores in variable names work" {
    export master_FORCE_TEST_FAIL_=true
    export BRANCH=master
    run process 
    #echo $output >&3 
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL_=true'
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL_="true"'    
    assert_success
}

@test "Stdin trailing underscores in variable names work" {
    export master_FORCE_TEST_FAIL_=true
    export BRANCH=master
    run cat <(env | process --stdin)
    #echo $output >&3 
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL_=true'
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL_="true"'    
    assert_success
}

#*******************************************************************
#* Legal values work correctly
#*******************************************************************

@test "Empty values work" {
    export master_FORCE_TEST_FAIL=
    export BRANCH=master
    run process 
    #echo $output >&3 
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL='
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL=""'    
    assert_success
}

@test "Quoted values work" {
    export master_FORCE_TEST_FAIL="true"
    export BRANCH=master
    run process 
    #echo $output >&3 
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL=true'
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL="true"'    
    assert_success
}

@test "Quoted space containing values work" {
    export master_FORCE_TEST_FAIL="this is a variable"
    export BRANCH=master
    run process 
    #echo $output >&3 
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL=this is a variable'
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL="this is a variable"'    
    assert_success
}

@test "Stdin empty values work" {
    export master_FORCE_TEST_FAIL=
    export BRANCH=master
    run cat <(env | process --stdin)
    #echo $output >&3 
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL='
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL=""'    
    assert_success
}

@test "Stdin quoted values work" {
    export master_FORCE_TEST_FAIL="true"
    export BRANCH=master
    run cat <(env | process --stdin)
    #echo $output >&3 
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL=true'
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL="true"'    
    assert_success
}

@test "Stdin quoted space containing values work" {
    export master_FORCE_TEST_FAIL="this is a variable"
    export BRANCH=master
    run cat <(env | process --stdin)
    #echo $output >&3 
    assert_line --index 2 --regexp '^# FROM master_FORCE_TEST_FAIL=this is a variable'
    assert_line --index 3 --regexp '^export FORCE_TEST_FAIL="this is a variable"'    
    assert_success
}

#*******************************************************************
#* Outputs are interpreted correctly
#*******************************************************************

# @test "Output works Quoted space containing values work" {
#     export master_FORCE_TEST_FAIL="hello"
#     export BRANCH=master
    
#     run cat <(. <(./process); env)
#     #echo $output >&3 
#     assert_output --regexp 'export FORCE_TEST_FAIL=hello'    
#     assert_success
# }


