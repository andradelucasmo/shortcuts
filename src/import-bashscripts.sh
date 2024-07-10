# Script directory
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SCRIPT_NAME=$(basename "$0")

# Import all bash script shortcut files
for folder in $SCRIPT_DIR/*; do
    if [ -d "$folder" ]; then
        for script in "$folder"/*.sh; do
            if [ -f "$script" ]; then
                source "$script"
            fi
        done
    fi
done