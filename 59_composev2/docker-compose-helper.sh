#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

if [ -n "${DEBUG_ENVIRONMENT-}" ];then 
    # if DEBUG_ENVIRONMENT is set
    env
    export
fi

#****************************************************************************
#** Print out usage
#****************************************************************************

function help() {
    local EXITCODE=0

    cat <<- EOF
usage: $SCRIPT_NAME options

OPTIONS:
    -a|--action             [wait|check|name]
    -s|--service            =<servicename>
    -f|--file               =<compose file>
    -e|--envfile            =<env-file>
    --debug                  
    -h --help                show this help

Examples:
    # show help
    ./$SCRIPT_NAME --help

    # check status of nginx service
    ./$SCRIPT_NAME --action=check --service=nginx --file=./docker-compose.yaml

    # check status of nginx service (with .env)
    ./$SCRIPT_NAME --action=check --service=timeout --file=./docker-compose.yaml --envfile=./compose.env

    # check docker name of redis service
    ./$SCRIPT_NAME --action=name --service=redis --file=./docker-compose.yaml --envfile=./compose.env

    # wait for exit of service
    ./$SCRIPT_NAME --action=wait --service=nginx --file=./docker-compose.yaml --envfile=./compose.env
    ./$SCRIPT_NAME --action=wait --service=timeout --file=./docker-compose.yaml --envfile=./compose.env

EOF

    return ${EXITCODE}
}

#****************************************************************************
#** 
#****************************************************************************

function compose_has_container_exited() {
    local service=$1
    local envfile=$2
    local composefile=$3

    if [[ "$envfile" != "" ]]; then
        envfile="--env-file $2"
    fi 
    if [[ "$composefile" != "" ]]; then
        composefile="-f $3"
    fi 
    set +e
    docker compose ${envfile} ${composefile} ps --format json | jq -e --arg service "$service" -r '.[] | select(.Service==$service and .State=="exited")' > /dev/null
    local exitcode=$?
    set -e
    if [[ $exitcode == 0 ]]; then
        echo "$1 has exited"
        return 1
    else
        echo "$1 has not exited"
        return 0
    fi
}

function waitfor_container_exit() {
    local service=$1
    local envfile=$2
    local composefile=$3

    local _continue=true
    local _count=0
    while $_continue; 
    do
        _count=$(( _count + 1 ))
        compose_has_container_exited "$service" "$envfile" "$composefile"
        if [[ $? != 0 ]]; then break; fi

        echo "Sleep"
        sleep 5
        # if [[ $(( _count % 10 )) == 0 ]]; then
        #     echo "Processes"
        #     docker compose --env-file ./compose.env -f ./docker-compose-tests.yaml --profile backend ps
        #     echo "Logs"
        #     docker compose --env-file ./compose.env -f ./docker-compose-tests.yaml --profile backend logs test
        # fi
    done
    echo "$service has exited"
}

function get_container_name_from_compose_service() {
    local service=$1
    local envfile=$2
    local composefile=$3

    if [[ "$envfile" != "" ]]; then
        envfile="--env-file $2"
    fi 
    if [[ "$composefile" != "" ]]; then
        composefile="-f $3"
    fi 

    docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose ${envfile} ${composefile} ps $service -q)"
}

#****************************************************************************
#** Main script 
#****************************************************************************

function main() {
    local ACTION= 
    local ENVFILE=  
    local COMPOSEFILE=         
    local SERVICE=         
    local EXITCODE=0
    local DEBUG=false  
    local HELP=false

    for i in "$@"
    do
    case $i in
        -a=*|--action=*)
            local -r ACTION="${i#*=}"
            shift # past argument=value
        ;;
        -e=*|--envfile=*)
            local -r ENVFILE="${i#*=}"
            shift # past argument=value
        ;; 
        -f=*|--file=*)
            local -r COMPOSEFILE="${i#*=}"
            shift # past argument=value
        ;;                    
        -s=*|--service=*)
            local -r SERVICE="${i#*=}"
            shift # past argument=value
        ;;                    
        --debug)
            set -x
            # shellcheck disable=SC2034
            local -r DEBUG=true   
            shift # past argument=value
        ;; 
        -h|--help)
            local -r HELP=true            
            shift # past argument=value
        ;;
        *)
            echo "Unrecognised ${i}"
            HELP=true
        ;;
    esac
    done    

    if [ "${HELP}" = true ] ; then
        EXITCODE=1
        help
    else
        if [ "${ACTION}" ]; then
            case "${ACTION}" in
                help)
                    help
                ;;
                name)
                    if [[ "$SERVICE" == "" ]]; then
                        >&2 echo "ERROR: servicename is not specified"
                        echo ""
                        help
                        exit 1
                    fi                
                    get_container_name_from_compose_service "${SERVICE}" "${ENVFILE}" "${COMPOSEFILE}"
                ;;
                wait)
                    if [[ "$SERVICE" == "" ]]; then
                        >&2 echo "ERROR: servicename is not specified"
                        echo ""
                        help
                        exit 1
                    fi                
                    waitfor_container_exit "${SERVICE}" "${ENVFILE}" "${COMPOSEFILE}"
                ;;
                check)
                    if [[ "$SERVICE" == "" ]]; then
                        >&2 echo "ERROR: servicename is not specified"
                        echo ""
                        help
                        exit 1
                    fi                
                    compose_has_container_exited "${SERVICE}" "${ENVFILE}" "${COMPOSEFILE}"
                ;;
                *)
                    echo "Unrecognised ${ACTION}"; 
                ;;
            esac
        else
            EXITCODE=1
            echo "No action specified use --action=<action>"
        fi
    fi
    return ${EXITCODE}
}

#echo "Start"
main "$@"
exit $?
