#!/bin/bash
# build_opts="--platform linux/amd64" # building at M1 mac for linux
echo "building vite image..."
cd vite && ./docker-build.sh
exit_code=$?
if [[ $exit_code != 0 ]]; then
    echo "build vite failed, exit $exit_code"
    exit $exit_code
fi
cd ..

echo "***"
echo "build rails7vite image..."
docker build $build_opts -t rails7vite .

# You can add your push command here, such as:
# docker push ...
