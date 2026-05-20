#!/bin/bash
# Get the absolute path of the script directory
SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Source all .sh files found recursively in the src directory
# We use 'find' to get files, even in subfolders
while IFS= read -r -d '' script; do
    if [ -f "$script" ]; then
        source "$script"
    fi
done < <(find "$SCRIPT_DIR/src" -name "*.sh" -print0 | sort)
