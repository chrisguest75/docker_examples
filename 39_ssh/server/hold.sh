#!/usr/bin/env bash

echo "Holding..."

function trap_hup_handler() {
    echo "SIGHUP handler exiting"
    exit $(( 128 + 1 ))
}
function trap_int_handler() {
    echo "SIGINT handler exiting"
    exit $(( 128 + 2 ))
}
function trap_quit_handler() {
    echo "SIGQUIT handler exiting"
    exit $(( 128 + 3 ))
}
function trap_term_handler() {
    echo "SIGTERM handler exiting"
    exit $(( 128 + 15 ))
}

trap trap_hup_handler SIGHUP
trap trap_int_handler SIGINT
trap trap_quit_handler SIGQUIT
trap trap_term_handler SIGTERM

rsyslogd
service ssh start
echo "Start sleep infinity"
sleep infinity

