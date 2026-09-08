#!/usr/bin/env bash

echo "Running Assignment 2 Automated Verification..."

# 1. Test help output
docker run --rm diagnostic-cli:latest help

# 2. Test invalid command handling
docker run --rm diagnostic-cli:latest invalid_cmd

# 3. Test healthcheck script inside container
docker run --rm --entrypoint /app/health-check.sh diagnostic-cli:latest
