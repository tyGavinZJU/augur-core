#!/bin/bash

set -e

environment=$1
shift

case "$environment" in
  "docker")
    docker run --rm -it \
      --env-file <(env | grep "PRIVATE_KEY\|TRAVIS\|TOKEN") \
      -e DEPLOY \
      -e ARTIFACTS \
      --entrypoint "bash"  \
      augurproject/augur-core:latest -- /app/source/support/deploy/deploy.sh $@
    ;;
  "direct")
    echo "Deploying to $@"
    bash ./source/support/deploy/deploy.sh $@
    ;;
  *)
    echo "Must specifiy either docker or direct as first argument"
    exit 1
    ;;
esac
