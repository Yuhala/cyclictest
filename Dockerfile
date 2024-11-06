# Use official ubuntu 20 base image
FROM occlum/occlum:latest-ubuntu20.04
# Use official ubuntu 20 base image
#FROM ubuntu:20.04

# Update
#RUN apt-get update && apt-get install -y build-essential


# Update
RUN apt-get update && apt-get install -y build-essential make vim libnuma-dev


# Set working directory 
WORKDIR /root/occlum-cyclictest

# Copy files to container
COPY cyclictest.c error.c rt-utils.c errro.h rt_numa.h rt-utils.h Makefile ./

# Compile program
#RUN make occlum-cpc

# Command to run the executable
#CMD ["./cpc"]
