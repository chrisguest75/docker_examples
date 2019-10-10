#!/usr/bin/env bash
#BASH_XTRACEFD="5"
PS4='$LINENO: '
set -x

ls -al /

ls -al /home/mynewuser
ls -al /home/mynewuser/myfile_mynewuser

cat /home/mynewuser/myfile_mynewuser/test.txt
cat /home/mynewuser/myfile_mynewuser/chowned_test2.txt
cat /home/mynewuser/myfile_mynewuser/touched_file.txt

touch /myfile_root/mynewuser.txt
