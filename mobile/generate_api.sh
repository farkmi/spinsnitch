#!/bin/bash
SWAGGER_URL=${1:-"http://localhost:8081/swagger.yml"}

echo "Fetching swagger.yml from $SWAGGER_URL..."

mkdir -p packages/spinsnitch_api

npx @openapitools/openapi-generator-cli generate \
    -i "$SWAGGER_URL" \
    -g dart \
    -o packages/spinsnitch_api \
    --additional-properties=pubName=spinsnitch_api,pubDescription=SpinSnitchApiClient
