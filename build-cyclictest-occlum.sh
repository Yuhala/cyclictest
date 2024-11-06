#!/bin/bash

imagename="occlum-cyclictest"
docker stop $(docker ps -a -q) # stop all containers
docker rm $(docker ps -a -q) # remove 

docker build -t $imagename .

# Build docker container from image
docker run -it --privileged -v /dev/sgx:/dev/sgx $imagename

