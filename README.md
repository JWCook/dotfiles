# Dotfiles
Config files and system setup scripts

# Prerequisites
Requires [`just`](https://github.com/casey/just#packages):
```sh
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to "$HOME/.local/bin"
```

# Installation
```sh
git clone https://github.com/JWCook/dotfiles && cd dotfiles
just install
```

# Linting
```sh
prek run -a
```
