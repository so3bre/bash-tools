# src/01-help.sh
# Centralized help utility for all bash tools

bt-help() {
    echo "=========================================="
    echo "  Bash Tools - Helper Utility"
    echo "=========================================="
    echo "Available commands:"
    echo "  lic     - Check DNF package licenses"
    echo "  flic    - Check Flatpak app licenses"
    echo "  bt-help - Display this help message"
    echo "=========================================="
    echo "Note: All tools are loaded automatically from src/ directory."
}
