FROM debian:jessie-slim

# MAINTAINER Jo Shields <jo.shields@xamarin.com>
# MAINTAINER Alexander Köplinger <alkpli@microsoft.com>

# based on dockerfile by Michael Friis <friism@gmail.com>

ENV MONO_VERSION 5.0.1.1

RUN apt-get update \
  && apt-get install -y curl git \
  && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian jessie/snapshots/$MONO_VERSION main" > /etc/apt/sources.list.d/mono-official.list \
  && apt-get update \
  && apt-get install -y binutils mono-devel ca-certificates-mono fsharp mono-vbnc nuget referenceassemblies-pcl \
  && rm -rf /var/lib/apt/lists/* /tmp/*

RUN git clone https://github.com/CoiniumServ/CoiniumServ.git ./CoiniumServ \
&& cd ./CoiniumServ \
git submodule init \
git submodule update \ 
mozroots --import --ask-remove \
xbuild build/CoiniumServ.sln /p:Configuration="Release" \

mono contrib/xunit/xunit.console.clr4.x86.exe src/Tests/bin/Release/CoiniumServ.Tests.dll
# && ls \
#&& pwd \
#&& cd /usr/local/bin/CoiniumServ/build/release \
#&& ls \
#&& pwd \
#&& sh /usr/local/bin/CoiniumServ/build/release/build.sh


EXPOSE 8081

CMD ["mono", "/usr/local/bin/CoiniumServ/build/release/CoiniumServ.exe"]
