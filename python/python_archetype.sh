#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR=$1

cd "$TARGET_DIR"

set -euo pipefail

PROJECT_NAME=$2
PACKAGE_NAME=$3

echo "Creating project: $PROJECT_NAME"

# Root structure
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Core directories
mkdir -p \
  src/$PACKAGE_NAME/domain/model \
  src/$PACKAGE_NAME/domain/service \
  src/$PACKAGE_NAME/application/use_cases \
  src/$PACKAGE_NAME/application/port/inbound \
  src/$PACKAGE_NAME/application/port/outbound \
  src/$PACKAGE_NAME/adapter/inbound \
  src/$PACKAGE_NAME/adapter/outbound \
  tests \
  docker \
  scripts

# Python package initialization
find src -type d -exec touch {}/__init__.py \;

# Main entrypoint
cp $SCRIPT_DIR/main.py $TARGET_DIR/$PROJECT_NAME

# pyproject.toml (uv-ready minimal config)
cp $SCRIPT_DIR/pyproject.toml $TARGET_DIR/$PROJECT_NAME

# Makefile
cp $SCRIPT_DIR/Makefile $TARGET_DIR/$PROJECT_NAME

# gitignore
cp $SCRIPT_DIR/gitignore $TARGET_DIR/$PROJECT_NAME/.gitignore

# github
cp -r $SCRIPT_DIR/github $TARGET_DIR/$PROJECT_NAME/.github

# LICENSE
cp $SCRIPT_DIR/MIT-LICENSE $TARGET_DIR/$PROJECT_NAME/LICENSE
