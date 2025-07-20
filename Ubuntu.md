# Ubuntu

## Ubuntu

### Essential
```sh
sudo apt update
sudo apt install openssh-server curl git wget zsh
```

### Fastfetch
```sh
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt install fastfetch
```

### Font
```sh
# Download the latest JetBrainsMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

# Create font directory and extract
mkdir -p ~/.local/share/fonts/JetBrainsMono
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono/

# Refresh font cache
fc-cache -fv

# Clean up
rm JetBrainsMono.zip
```

### Set `zsh` as default shell
```sh
chsh -s $(which zsh)
```

### ohmyposh
```sh
sudo apt install zoxide
echo 'export PATH=$PATH:$HOME/.local/bin' >> .zshrc
source .zshrc
curl -s https://ohmyposh.dev/install.sh | bash -s
eval "$(oh-my-posh init zsh)"
```

### Custom theme
```sh
cd ~/.cache/oh-my-posh/themes
wget https://raw.githubusercontent.com/rodrigopolo/cheatsheets/refs/heads/master/rodrigopolo.omp.json
eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/rodrigopolo.omp.json)"
```

### fzf
```sh
sudo apt remove fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

> **Note:** Edit the `.zshrc` as the `zshrc-ubuntu.sh`

### First run
```sh
source .zshrc
```

### Ghosty
```sh
sudo snap install ghostty --classic
```

#### Custom Theme
```sh
# Themes in /snap/ghostty/102/share/ghostty/themes
mkdir -p ~/.config/ghostty/themes
cat > ~/.config/ghostty/themes/Rodrigo\ Polo << 'EOF'
palette = 0=#1a1a1a
palette = 1=#ed1b21
palette = 2=#2dc55e
palette = 3=#ecba0f
palette = 4=#2a84d2
palette = 5=#a716e4
palette = 6=#168cda
palette = 7=#83868e
palette = 8=#575653
palette = 9=#de352e
palette = 10=#1dd361
palette = 11=#f3bd09
palette = 12=#1e97df
palette = 13=#bf25f1
palette = 14=#259fe6
palette = 15=#ffffff
background = #1e1e1e
foreground = #ffffff
cursor-color = #98989d
cursor-text = #ffffff
selection-background = #3f638b
selection-foreground = #ffffff
EOF
```

#### Custom Settings
```sh
cat >> ~/.config/ghostty/config << 'EOF'
# Custom settings

# To list themes: ghostty +list-themes
theme = Rodrigo Polo

window-height = 34
window-width = 125
background-opacity = 0.80
background-blur-radius = 10
cursor-style = block
clipboard-trim-trailing-spaces = true
# font-family = MesloLGS NF
font-family = JetBrainsMono Nerd Font
font-size = 14

# No ligatures
font-feature = -calt
font-feature = -dlig
font-feature = -liga

# window-decoration = false
# background = 000000

keybind = shift+enter=text:\n
EOF
```

### Other tools
```sh
sudo apt install btop ffmpeg mediainfo exiftool bat
```

### FFmpeg Progress Bar
```sh
cd ~/.local/bin
wget https://github.com/rodrigopolo/fpb/releases/download/v1.0.2/fpb-linux-amd64 -O fpb
chmod +x fpb
```

### Install Ubuntu Desktop on Ubuntu Server
```sh
sudo apt update
sudo apt install ubuntu-desktop
sudo reboot
```

### Node
```sh
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 24

# Verify the Node.js version:
node -v # Should print "v24.4.1".
nvm current # Should print "v24.4.1".

# Verify npm version:
npm -v # Should print "11.4.2".
```
https://nodejs.org/en/download/current


### Rust
```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
https://www.rust-lang.org/tools/install

Tauri Deps
```sh
sudo apt update
sudo apt install pkg-config
sudo apt install libgdk-pixbuf-2.0-dev pkg-config
sudo apt install build-essential curl wget file libgtk-3-dev libwebkit2gtk-4.0-dev librsvg2-dev
sudo apt install libwebkit2gtk-4.1-dev
```

Build
```sh
# Basic
npm run tauri build

# Explicit
npm run tauri build -- --target x86_64-unknown-linux-gnu

# For 32-bit x86 Linux
npm run tauri build -- --target i686-unknown-linux-gnu

# Install the target toolchain
rustup target add aarch64-unknown-linux-gnu

# Install cross-compilation tools
sudo apt install gcc-aarch64-linux-gnu

# For ARM64 Linux
npm run tauri build -- --target aarch64-unknown-linux-gnu

```

`~/.cargo/config.toml`
```toml
[target.aarch64-unknown-linux-gnu]
linker = "aarch64-linux-gnu-gcc"
```

### Go
```sh
# Install
wget https://go.dev/dl/go1.24.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz

# Add path
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.zshrc

# Remove before update
sudo rm -rf /usr/local/go
```