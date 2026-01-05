#!/usr/bin/env bash
# Requires docker 17.05 or higher

set -e

echo ""
echo "===================================="
echo "  Building dcrdevdocs docker image  "
echo "===================================="
echo ""

IMAGE_NAME=decred/dcrdevdocs

if [ "$1" != "" ]; then
    IMAGE_NAME=$1
fi

# The default logging of the docker builder folds output which can hide
# important DEBUG/INFO messages. Use --progress==plain to prevent this.
docker build --progress=plain -t $IMAGE_NAME .

echo ""
echo "==================="
echo "  Build complete"
echo "==================="
echo ""
echo "You can now run dcrdevdocs with the following command:"
echo "    docker run -d --rm -p <local port>:80 $IMAGE_NAME:latest"
echo ""
