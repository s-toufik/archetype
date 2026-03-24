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
authors = [
    { name="Toufik Saouchi", email="toufik.saouchi@gmail.com" },
]
description = "description"
readme = "README.md"
requires-python = ">=3.14"
classifiers = [
    "Programming Language :: Python :: 3",
    "Operating System :: OS Independent",
]
license = "MIT"
dependencies = [
    "numpy",
    "python-dotenv",
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

[project.urls]
Homepage = "https://???"
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

git_init:
    git init
    git add --all
    git commit -m "init project"
    git checkout -b develop
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

# LICENSE
cat > LICENSE <<EOF
MIT License

Copyright (c) 2026 $PROJECT_NAME

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF