#!/bin/bash

# This script will be used to upload docker images to docker registry.
# It assumes that the user is signed-in to docker registry before
# running it

# Tags for Docker images
SERVER_TAG="vtest"
CLIENT_TAG="vtest"
REGISTRY="smqasims"

# Build and upload server image
docker build -t server:$SERVER_TAG server/.
docker tag server:$SERVER_TAG $REGISTRY/server:$SERVER_TAG
docker push $REGISTRY/server:$SERVER_TAG

# Build and upload client image
docker build -t client:$CLIENT_TAG client/.
docker tag client:$CLIENT_TAG $REGISTRY/client:$CLIENT_TAG
docker push $REGISTRY/client:$CLIENT_TAG
