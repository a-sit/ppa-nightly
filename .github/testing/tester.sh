#!/bin/bash
set -o nounset   # abort on unbound variable
#set -o errexit   # abort on nonzero exitstatus
#set -o pipefail  # don't hide errors within pipes



if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <DockerfileNamePrefix>"
    echo "Example: $0 DebianBookworm"
    echo "This will build Dockerfile 'DebianBookworm.Dockerfile' and run it as container 'debianbookworm'"
    exit 1
fi


DOCKERFILENAME="$1" # e.g., DebianBookworm
CONTAINERNAME="$(echo "$DOCKERFILENAME" | tr '[:upper:]' '[:lower:]')" # e.g., debianbookworm


docker build --file "$DOCKERFILENAME.Dockerfile" -t $CONTAINERNAME .

docker run --rm -v "$PWD/testHarness.sh:/testHarness.sh" $CONTAINERNAME sh /testHarness.sh

