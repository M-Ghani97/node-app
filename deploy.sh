#!/bin/bash
registry = $1
BUILD_NUMBER = $2
prev_BUILD = $3

docker stop $registry:$prev_BUILD && docker rm $registry:$prev_BUILD
docker pull $registry:$BUILD_NUMBER && docker run -d --name=node-app-$BUILD_NUMBER -p 3000:3000 $registry:$BUILD_NUMBER