#!/usr/bin/env bash
# Install latest neovim from GitHub releases
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux64.tar.gz
ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim
rm nvim-linux64.tar.gz
