#!/usr/bin/env bash
#while true; do                                                               
#  echo -e "HTTP/1.1 200 OK\n\n $(date)" | nc -l -p 8080 -q 1
#done

#https://www.sans.org/security-resources/sec560/netcat_cheat_sheet_v1.pdf

# TODO: create a logic script in netcat to open reverse shell when 
echo "Start stupid webserver on port 8080"
nc -l -p 8080 -e ./server_logic.sh

