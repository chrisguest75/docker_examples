# README

Demonstrates timing differences with layers building and running

Build some image with ten layers.  Then extend to 50 layers to see if timing is linear.

ℹ️ NOTE: So far it doesn't seem that much slower to have lots of layers during execution. 

## Test building layers

### Test Functions

```sh
function build_normal() {
    docker build --no-cache -f $1.Dockerfile -t $1 .
} 
function build_buildkit() {
    docker buildx build --no-cache -f $1.Dockerfile -t $1 .
} 
```

### Normal builds (10 layers)

```sh
# Use normal docker build
. ./time-it.sh build_normal 10 10layers  

# Will output something like this
SUM:100.274 COUNT:10 AVG:10.0274 MEDIAN:9.64479 MIN:9.2718579769 MAX:12.4239759445
SUM:101.992 COUNT:10 AVG:10.1992 MEDIAN:10.3247 MIN:9.4263720512 MAX:10.7601661682
```

### Use buildkit (10 layers)

```sh
. ./time-it.sh build_buildkit 10 10layers  

# Will output something like this
SUM:41.9023 COUNT:10 AVG:4.19023 MEDIAN:3.85896 MIN:3.5423209668 MAX:5.5610890388
SUM:39.9735 COUNT:10 AVG:3.99735 MEDIAN:3.90452 MIN:3.6023778915 MAX:4.8426160812
```

### Normal builds (50 layers)

```sh
# Use normal docker build
. ./time-it.sh build_normal 3 50layers  

# Will output something like this
SUM:104.369 COUNT:3 AVG:34.7898 MEDIAN:32.6690368653 MIN:32.0666589736 MAX:39.6336610317
```

### Use buildkit (50 layers)

```sh
. ./time-it.sh build_buildkit 3 50layers  

# Will output something like this
SUM:55.5448 COUNT:3 AVG:18.5149 MEDIAN:18.7924640178 MIN:17.9259240627 MAX:18.8263990879
```

## Many layers and finding files

Attempt to work out if using lots of layers slows down file access.

```sh
# few layers
docker build --no-cache -f execute_speed.Dockerfile --target fewlayers -t few_execute_speed .

docker run -it --rm --entrypoint /usr/local/bin/bash few_execute_speed ./run_test.sh 300

18422
SUM:35.4485 COUNT:300 AVG:0.118162 MEDIAN:0.112636 MIN:.094567 MAX:1.075746

# many layers
docker build --no-cache -f execute_speed.Dockerfile --target manylayers -t many_execute_speed .

docker run -it --rm --entrypoint /usr/local/bin/bash many_execute_speed ./run_test.sh 300

18251
SUM:35.5697 COUNT:300 AVG:0.118566 MEDIAN:0.117266 MIN:.099146 MAX:.261704
```
