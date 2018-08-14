# docker-shaka-packager

A docker image that contains a statically linked version of the shaka packager which can be copied out to be used in other images. 

The built binary is placed in `/opt/shaka_packager/bin`

## Usage

```
docker run -v output:/output/ offbytwo/shaka-packager cp /opt/shaka_packager/bin/packager /output/
```

This will copy the build `packager` command to the output directory
