#!/usr/bin/env bash
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

function help() {
    cat <<- EOF
usage: $SCRIPT_NAME options

OPTIONS:
    -h --help -?               show this help
    -p --pipe                  pipe file
    -l --list                  list all files in <target>
    -s --show                  cat a <target> file
    -t|--target=<target>       write file output to <target>

    --debug                    debug mode

Examples:
    $SCRIPT_NAME --help 

EOF
}

# if no variables are passed
if [[ -z "$@" ]]; then
    help
    exit 0
fi 

TARGET="./"
PIPE=false  
LIST=false
DEBUG=false

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;;
    -t=*|--target=*)
        TARGET="${i#*=}"
        shift # past argument=value
    ;;
    -p|--pipe)
        # shellcheck disable=SC2034
        PIPE=true
        shift
    ;;    
    -l|--list)
        # shellcheck disable=SC2034
        LIST=true
        shift
    ;;
    -s|--show)
        # shellcheck disable=SC2034
        SHOW=true
        shift
    ;;
    --debug)
        set -x
        # shellcheck disable=SC2034
        DEBUG=true
        shift
    ;;     
esac
done    


if [ "$LIST" = true ]; then
    ls -la "$TARGET"
fi

if [ "$PIPE" = true ]; then
    cat - > "$TARGET"
fi

if [ "$SHOW" = true ]; then
    cat "$TARGET"
fi
