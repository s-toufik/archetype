#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cargo generate --path "$SCRIPT_DIR/directory-struc" --vcs none
