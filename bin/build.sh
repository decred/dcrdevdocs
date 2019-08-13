#!/bin/bash -e
# Requires docker 17.05 or higher

echo ""
echo "================================="
echo "  Building dcrdevdocs docker image  "
echo "================================="
echo ""

docker build -t decred/dcrdevdocs .

echo ""
echo "==================="
echo "  Build complete"
echo "==================="
echo ""
echo "You can now run dcrdevdocs with the following command:"
echo "    docker run -d --rm -p <local port>:80 decred/dcrdevdocs:latest"
echo ""
