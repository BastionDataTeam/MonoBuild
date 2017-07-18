# The Official Mono Docker container
# https://registry.hub.docker.com/_/mono/
FROM mono:3.12

MAINTAINER Jeffrey Ness "jeffrey.ness@...."

# The TCP ports this Docker container exposes the the host.
EXPOSE 8081

RUN apt-get install -y git \
  && rm -rf /var/lib/apt/lists/*

# Add the project tarball to Docker container
RUN git clone https://github.com/CoiniumServ/CoiniumServ.git ./CoiniumServ \
&& cd ./CoiniumServ \
&& git submodule init \
&& git submodule update \
&& mozroots --import --ask-remove

# Build our project
RUN nuget restore ./CoiniumServ/build/CoiniumServ.sln
RUN xbuild ./CoiniumServ/build/CoiniumServ.sln /p:Configuration="Release"

# Change to our artifact directory
WORKDIR ./CoiniumServ

# Entry point should be mono binary
ENTRYPOINT mono ./CoiniumServ/build/release/CoiniumServ.exe
