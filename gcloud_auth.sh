#!/bin/bash

set -e

: ${GOOGLE_AUTH_JSON:?'Set the GOOGLE_AUTH_JSON environment variable'}
: ${GOOGLE_AUTH_EMAIL:?'Set the GOOGLE_AUTH_EMAIL environment variable'}
: ${GOOGLE_PROJECT_ID:?'Set the GOOGLE_PROJECT_ID environment variable'}
: ${GOOGLE_CLUSTER_ZONE:?'Set the GOOGLE_CLUSTER_ZONE environment variable'}
: ${GOOGLE_CLUSTER_NAME:?'Set the GOOGLE_CLUSTER_NAME environment variable'}

echo "Logging into Google GCR"
echo $GOOGLE_AUTH_JSON > /keyconfig.json
export CLOUDSDK_CONTAINER_USE_CLIENT_CERTIFICATE=True
export CLOUDSDK_CORE_DISABLE_PROMPTS=1
gcloud auth activate-service-account $GOOGLE_AUTH_EMAIL --key-file /keyconfig.json --project $GOOGLE_PROJECT_ID
gcloud config set project $GOOGLE_PROJECT_ID
gcloud config set compute/zone $GOOGLE_CLUSTER_ZONE
gcloud config set container/cluster $GOOGLE_CLUSTER_NAME
gcloud config set account $GOOGLE_AUTH_EMAIL
gcloud container clusters get-credentials $GOOGLE_CLUSTER_NAME
