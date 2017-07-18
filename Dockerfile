# The Official Mono Docker container
# https://registry.hub.docker.com/_/mono/
FROM mono:3.12

MAINTAINER Jeffrey Ness "jeffrey.ness@...."

# The TCP ports this Docker container exposes the the host.
EXPOSE 8081

# Change to our artifact directory
WORKDIR /CoiniumServ

RUN apt-get -y update &&\
    apt-get -y upgrade &&\
    apt-get install -y --force-yes wget &&\
    apt-get clean

COPY CoiniumCopy.sh /

# Entry point should be mono binary
ENTRYPOINT /bin/bash
