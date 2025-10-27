#!/usr/bin/env bash

set -e

echo "🔄 Resetting Neovim and LazyVim setup..."

targets=(
  "$HOME/.local/share/nvim"
  "$HOME/.local/state/nvim"
  "$HOME/.cache/nvim"
  "$HOME/.local/share/mason"
  "$HOME/.local/share/nvim/lazy"
)

for path in "${targets[@]}"; do
  if [ -d "$path" ]; then
    echo "🗑 Removing: $path"
    rm -rf "$path"
  else
    echo "✅ Not found (already clean): $path"
  fi
done

echo "🎉 Neovim and LazyVim have been reset!"
