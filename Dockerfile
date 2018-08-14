FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

# update, and install basic packages
RUN apt-get update
RUN apt-get install -y build-essential curl git python
RUN apt-get -y clean
RUN rm -r /var/lib/apt/lists/*

# install depot_tools http://www.chromium.org/developers/how-tos/install-depot-tools
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
    export PATH=/depot_tools:$PATH && \
    mkdir /opt/shaka_packager_build && \
    cd /opt/shaka_packager_build && \
    PATH=/depot_tools:$PATH gclient config https://www.github.com/google/shaka-packager.git --name=src && \
    PATH=/depot_tools:$PATH gclient sync --no-history -r v2.1.1 && \
    mkdir -p /opt/packager/bin /opt/packager/lib && \
    cd src && ninja -C /opt/shaka_packager_build/src/out/Release && \
    mkdir -p /opt/packager/bin /opt/packager/lib && \
    cp /opt/shaka_packager_build/src/out/Release/packager /opt/packager/bin && \
    cp /opt/shaka_packager_build/src/out/Release/mpd_generator /opt/packager/bin && \
    cp /opt/shaka_packager_build/src/out/Release/*.a /opt/packager/lib/ && \
    rm -rf /opt/shaka_packager_build && \
    rm -rf /opt/depot_tools
    
ENV PATH /opt/packager/bin:$PATH
