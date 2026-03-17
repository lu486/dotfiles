#!/bin/bash
# dotfiles installer - source shell functions into .zshrc
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
MARKER="# >>> dotfiles >>>"
END_MARKER="# <<< dotfiles <<<"

setup_zsh() {
    local zshrc="$HOME/.zshrc"
    local source_line="source \"$DOTFILES_DIR/shell/functions.sh\""

    # Remove old dotfiles block if exists
    if grep -q "$MARKER" "$zshrc" 2>/dev/null; then
        sed -i '' "/$MARKER/,/$END_MARKER/d" "$zshrc"
        echo "Removed old dotfiles block"
    fi

    # Remove inline s function if exists
    if grep -q "^function s()" "$zshrc" 2>/dev/null; then
        sed -i '' '/^# SSH.*快速连接/,/^}/d' "$zshrc"
        echo "Removed inline s function"
    fi

    # Append source block
    cat >> "$zshrc" << EOF

$MARKER
$source_line
$END_MARKER
EOF
    echo "Added dotfiles source to $zshrc"
}

setup_zsh
echo "Done! Run 'source ~/.zshrc' or open a new terminal."
