#!/bin/bash

TITLE="$1"
ID="$2"
TEMPLATE_NAME="$3"
VAULT_DIR="$HOME/Documents/vault/200-Permanent"

if [ -z "$TITLE" ] || [ -z "$ID" ] || [ -z "$TEMPLATE_NAME" ]; then
  echo "Usage: $0 <title> <id> <template-name>"
  exit 1
fi

# Capture the output of zk
NOTE_PATH=$(zk new --template="$TEMPLATE_NAME.md" --title="$TITLE" --id="$ID" "$VAULT_DIR"  --print-path)

# Echo the path so Lua can capture it
echo "$NOTE_PATH"
