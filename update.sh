#!/bin/bash
# Pull latest dotfiles from GitHub
cd "$(dirname "$0")" && git pull --ff-only
echo "Dotfiles updated. Changes take effect in new terminals."
