#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR=$1

cd "$TARGET_DIR"

set -euo pipefail

PROJECT_NAME=$2

echo "Creating project: $PROJECT_NAME"

# Root structure
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Core directories
mkdir -p \
  src/domain/models \
  src/domain/services \
  src/application/use_cases \
  src/application/ports/inbound \
  src/application/ports/outbound \
  src/adapters/inbound \
  src/adapters/outbound \
  tests \
  docker \
  scripts

# Python package initialization
find src -type d -exec touch {}/__init__.py \;

# Main entrypoint
cp $SCRIPT_DIR/main.py $TARGET_DIR/$PROJECT_NAME/src

# pyproject.toml (uv-ready minimal config)
cp $SCRIPT_DIR/pyproject.toml $TARGET_DIR/$PROJECT_NAME

# Makefile
cp $SCRIPT_DIR/Makefile $TARGET_DIR/$PROJECT_NAME

# gitignore
cp $SCRIPT_DIR/gitignore $TARGET_DIR/$PROJECT_NAME/.gitignore

# LICENSE
cp $SCRIPT_DIR/MIT-LICENSE $TARGET_DIR/$PROJECT_NAME/LICENSE
