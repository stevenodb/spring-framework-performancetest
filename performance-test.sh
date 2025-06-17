#!/bin/bash

GRADLE_DIR="${PWD}/gradle_user_home"

# Create test directory if it doesn't exist
mkdir -p "$GRADLE_DIR"

export GRADLE_USER_HOME=$GRADLE_DIR

echo "=== DEPENDENCY SETUP ==="
# One-time full build to download dependencies
./gradlew build --refresh-dependencies -q --continue -x :spring-webflux:test -x checkstyleNohttp || true
./gradlew clean -q

echo "=== PERFORMANCE TESTING ==="
time ./gradlew clean build -x :spring-webflux:test -x checkstyleNohttp --rerun-tasks --offline --parallel
