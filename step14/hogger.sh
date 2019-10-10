#!/usr/bin/env bash
echo "hogging"
#stress --vm-bytes 2G -v  --vm-keep --vm 1
#stress-ng --vm-bytes 2022492k --vm-keep -m 1
#stress-ng --vm-bytes $(awk '/MemAvailable/{printf "%d\n", $2 * 1.1;}' < /proc/meminfo)k --vm-keep -m 1
#stress-ng --vm-bytes $(awk '/MemAvailable/{printf "%d\n", $2 * 0.9;}' < /proc/meminfo)k --vm-keep -m 1
#stress-ng --vm 5 --vm-bytes 95% --vm-method all --verify -t 1m -v
#stress-ng --vm 1 --vm-bytes 95% --vm-method all --verify -t 1m -v --abort --oomable

function malloc() {
  if [[ $# -eq 0 || $1 -eq '-h' || $1 -lt 0 ]] ; then
    echo -e "usage: malloc N\n\nAllocate N mb, wait, then release it."
  else 
    N=$(free -m | grep Mem: | awk '{print int($2/10)}')
    if [[ $N -gt $1 ]] ;then 
      N=$1
    fi
    sh -c "MEMBLOB=\$(dd if=/dev/urandom bs=1GB count=$N) ; sleep 1"
  fi
}

#yes | tr \\n x | head -c $((1024*1024*500)) | grep n
#yes | tr \\n x | head -c $((1024*1024*1024)) | pv -L $((1024*1024*100)) | grep n

malloc '10024' '1024'
EXITCODE=$?
exit ${EXITCODE}