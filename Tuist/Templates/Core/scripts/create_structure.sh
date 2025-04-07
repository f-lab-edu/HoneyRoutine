#!/bin/bash

MODULE_NAME=$1
BASE_PATH="Core/${MODULE_NAME}"

mkdir -p "${BASE_PATH}/Sources/Interface"
mkdir -p "${BASE_PATH}/Sources/Implementation"
mkdir -p "${BASE_PATH}/Tests/UnitTests"
mkdir -p "${BASE_PATH}/Tests/Testing"
