# vfx_rs_environment

This repo builds babble an all of its dependencies inside of a docker image.

# Setup
Make sure you have the submodules checked out.

> git submodule update --init

# Build
To build you need to run docker.
> docker build -t luketitley/vfxrs_env_usd .

Once the build is complete you will have a docker image that contains babble and all of its dependencies.
