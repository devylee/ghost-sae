#!/bin/bash

docker run --name ghost-sae -p 7000:2467 --env-file=./env-dev.list -v /var/storage/ghost:/var/storage/ghost ghost-sae
