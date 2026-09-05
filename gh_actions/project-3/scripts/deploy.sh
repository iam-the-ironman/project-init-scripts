#!/usr/bin/env bash
# Deploy pixelpost to /opt/pixelpost on this machine.
# Refuses to run without a deploy token in the environment.
set -euo pipefail
: "${DEPLOY_TOKEN:?DEPLOY_TOKEN is not set}"
mkdir -p /opt/pixelpost
cp pixelpost/*.py /opt/pixelpost/
cp VERSION /opt/pixelpost/VERSION
date -u +"deployed at %Y-%m-%dT%H:%M:%SZ" > /opt/pixelpost/release.info
echo "deployed version $(cat VERSION) to /opt/pixelpost"
