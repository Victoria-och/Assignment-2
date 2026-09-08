#!/usr/bin/env bash

# Health check script for Docker container
if [ -f "/app/diagnostic.sh" ] && [ -x "/app/diagnostic.sh" ]; then
    echo "Health Check Passed: Diagnostic CLI available."
    exit 0
else
    echo "Health Check Failed: Diagnostic CLI missing or non-executable."
    exit 1
fi
