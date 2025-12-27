#!/bin/bash
mkdir -p packages/spinsnitch_api
npx openapi-generator-cli generate \
    -i api/swagger.yml \
    -g dart \
    -o packages/spinsnitch_api \
    --additional-properties=pubName=spinsnitch_api,pubDescription=SpinSnitchApiClient
