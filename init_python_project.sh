#!/usr/bin/env bash

cd $1

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
  src/ports/inbound \
  src/ports/outbound \
  src/adapters/inbound \
  src/adapters/outbound \
  tests \
  docker \
  scripts

# Python package initialization (better than .gitkeep)
find src -type d -exec touch {}/__init__.py \;

# Main entrypoint
cat > src/main.py <<EOF
def main():
    print("Hello friend, happy coding")

if __name__ == "__main__":
    main()
EOF

# pyproject.toml (uv-ready minimal config)
cat > pyproject.toml <<EOF
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
description = "market price analysis system"
readme = "README.md"
requires-python = ">=3.14"
dependencies = [
    "numpy",
    "fastapi",
    "uvicorn[standard]",
    "sqlalchemy>=2.0",
    "asyncpg",
    "httpx",
    "pydantic>=2",
    "python-dotenv",
    "openai",
]

[dependency-groups]
dev = [
    "pytest",
    "hypothesis>=6.151.9",
    "pytest-asyncio",
    "ruff",
    "mypy"
]

[tool.ruff]
line-length = 100
target-version = "py314"

[tool.mypy]
python_version = "3.14"
strict = true
EOF

# Makefile
cat > Makefile <<'EOF'
venv:
	uv venv

install:
	uv sync

install_dev:
	uv sync --group dev

run:
	uv run uvicorn price.main:app --reload

test:
	uv run pytest

lint:
	uv run ruff check .

format:
	uv run ruff format .
EOF

# Optional .gitignore
cat > .gitignore <<EOF
# Python-generated files
__pycache__/
uv.lock
*.pyc
*.py[oc]
build/
dist/
wheels/
*.egg-info

# Virtual environments
.venv

# env
.env

# IDEs
.idea/
.vscode

# Dev
.hypothesis
EOF
