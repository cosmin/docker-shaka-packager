FROM ubuntu:bionic as build

# update, and install basic packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && apt-get install -y build-essential curl git python && apt-get -y clean && rm -r /var/lib/apt/lists/*

# install depot_tools http://www.chromium.org/developers/how-tos/install-depot-tools
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH /depot_tools:$PATH
WORKDIR /opt/shaka_packager_build

ARG shaka_packager_version=v2.3.0
RUN gclient config https://www.github.com/google/shaka-packager.git --name=src
RUN gclient sync --no-history -r ${shaka_packager_version}
RUN mkdir -p /opt/packager/bin /opt/packager/lib
WORKDIR src
RUN ninja -C /opt/shaka_packager_build/src/out/Release

FROM ubuntu:bionic
WORKDIR /opt/packager/lib
COPY --from=build /opt/shaka_packager_build/src/out/Release/*.a .
WORKDIR /opt/packager/bin
COPY --from=build /opt/shaka_packager_build/src/out/Release/packager .
COPY --from=build /opt/shaka_packager_build/src/out/Release/mpd_generator .
ENV PATH /opt/packager/bin:$PATH
