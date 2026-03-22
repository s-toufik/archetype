#!/usr/bin/env bash

set -euo pipefail

PROJECT_NAME=$1
PACKAGE_NAME=$2

echo "Creating project: $PROJECT_NAME"

# Root structure
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Core directories
mkdir -p \
  src/$PACKAGE_NAME/domain/models \
  src/$PACKAGE_NAME/domain/services \
  src/$PACKAGE_NAME/application/use_cases \
  src/$PACKAGE_NAME/ports/inbound \
  src/$PACKAGE_NAME/ports/outbound \
  src/$PACKAGE_NAME/adapters/inbound \
  src/$PACKAGE_NAME/adapters/outbound \
  tests \
  docker \
  scripts

# Python package initialization (better than .gitkeep)
find src -type d -exec touch {}/__init__.py \;

# Main entrypoint
cat > src/$PACKAGE_NAME/main.py <<EOF
def main():
    print("Hello from $PACKAGE_NAME")

if __name__ == "__main__":
    main()
EOF

# pyproject.toml (uv-ready minimal config)
cat > pyproject.toml <<EOF
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
description = "Hexagonal architecture service"
requires-python = ">=3.12"
dependencies = []

[tool.uv]
dev-dependencies = [
    "pytest",
    "ruff",
    "mypy"
]
EOF

# Makefile (automation best practice)
cat > Makefile <<'EOF'
install:
	uv sync

run:
	uv run python -m my_service.main

test:
	uv run pytest

lint:
	uv run ruff check .

format:
	uv run ruff format .
EOF

# Optional .gitignore
cat > .gitignore <<EOF
.venv/
__pycache__/
*.pyc
uv.lock
.env
EOF
