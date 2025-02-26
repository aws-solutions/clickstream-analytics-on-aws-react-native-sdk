#!/usr/bin/env bash

# sh ./deployment/run-unit-tests.sh

set -euxo pipefail

log() {
    echo -e "[INFO] $1"
}

error() {
    echo -e "[ERROR] $1"
    exit 1
}

for cmd in node npm yarn; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed"
        exit 1
    fi
done

# Install dependencies
log "Installing dependencies..."
yarn install || error "Failed to install dependencies"


# Run prettier format
log "Running prettier..."
yarn run format || error "Prettier failed."

# Run linting
log "Running linter..."
yarn run lint || error "Linting failed."

# Run tests
log "Running tests..."
yarn run test || error "Tests failed"

log "All tests passed!"
