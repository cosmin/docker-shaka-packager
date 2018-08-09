FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

# update, and install basic packages
RUN apt-get update
RUN apt-get install -y build-essential curl git python

# install depot_tools http://www.chromium.org/developers/how-tos/install-depot-tools
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH /depot_tools:$PATH

# install shaka-packager
RUN mkdir /opt/shaka_packager
WORKDIR /opt/shaka_packager
RUN gclient config https://www.github.com/google/shaka-packager.git --name=src
RUN gclient sync --no-history -r v2.1.1
RUN cd src && ninja -C out/Release
VOLUME /output
ENTRYPOINT ["cp", "/opt/shaka_packager/out/Release/packager", "/output/packager"]