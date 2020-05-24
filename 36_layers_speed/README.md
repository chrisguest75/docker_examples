# README
Demonstrates timing differences with layers building and running

```sh
function under_test() {
    docker build --no-cache -f 10layers.Dockerfile -t 10layers .
} 
. ./time-it.sh under_test 10  
```


```sh
# microsecond 1 millionth of second
start=${EPOCHREALTIME}
docker build --no-cache -f 100layers.Dockerfile -t 100layers .
#sleep 10
end=${EPOCHREALTIME}
runtime=$(bc <<< "(${end} - ${start})")
echo "${runtime} seconds"
#echo "scale=2;${runtime}/1000" | bc
```