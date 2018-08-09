# docker-shaka-packager

A docker image that contains a statically linked version of the shaka packager which can be copied out to be used in other images

## Usage

```
docker run -v output:/output/ offbytwo/shaka-packager
```

This will copy the build `packager` command to the output directory
