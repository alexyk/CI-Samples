#!/bin/bash

set -e

echo "Caches Status"
docker image inspect $(docker image ls -aq) --format {{.Size}} | awk '{totalSizeInBytes += $0} END {print totalSizeInBytes}'
