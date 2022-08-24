#!/bin/bash
# build_opts="--platform linux/amd64" # building at M1 mac for linux
docker build $build_opts -t rails7vite-assets .
