#!/data/data/com.termux/files/usr/bin/bash

# ───────────────────────────────────────────────
# Colors
# ───────────────────────────────────────────────
RC='\033[0m'
RED='\033[31m'
YELLOW='\033[33m'
CYAN='\033[36m'
GREEN='\033[32m'

echo -e "${GREEN}Welcome from melsiir, I hope you find my dotfiles useful.${RC}"

# ───────────────────────────────────────────────
# Restore interactive input even when piped (curl | bash)
# ───────────────────────────────────────────────
if ! [[ -t 0 ]]; then
  if [[ -e /dev/tty ]]; then
    exec </dev/tty
  else
    echo -e "${RED}Error: Cannot open /dev/tty — interactive mode not possible.${RC}"
    exit 1
  fi
fi

# ───────────────────────────────────────────────
# Helpers
# ───────────────────────────────────────────────
command_exists() { command -v "$1" >/dev/null 2>&1; }

# ───────────────────────────────────────────────
# 1. Clone Repo Function
# ───────────────────────────────────────────────
cloneRepo() {
  echo -e "${CYAN}▶ Updating package list${RC}"
  apt update -y

  echo -e "${CYAN}▶ Installing git${RC}"
  apt install -y git

  echo -e "${CYAN}▶ Cloning dotfiles repository${RC}"
  git clone https://github.com/melsiir/dotfiles 2>/dev/null || {
    echo -e "${YELLOW}Repo already exists or clone failed. Skipping.${RC}"
  }
}

# ───────────────────────────────────────────────
# 2. Install Required Packages
# ───────────────────────────────────────────────
installPackages() {
  echo -e "${CYAN}▶ Installing required packages${RC}"

  if command_exists termux-setup-storage; then
    termux-setup-storage
  fi

  packages="git fish lua54 neovim fzf eza make cmake zip tree fd bat \
            nodejs starship openssl-tool wget2 unzip unrar ripgrep \
            iproute2 aria2 jq which gh"

  DEBIAN_FRONTEND=noninteractive apt install -y \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" \
    $packages
}

# ───────────────────────────────────────────────
# 3. Copy Config
# ───────────────────────────────────────────────
copyConfig() {
  echo -e "${CYAN}▶ Copying configs${RC}"
  cp --update=all ./dotfiles/. ~/.config/
  cp --update=all ~/.config/.npmrc ~/
  cp --update=all ~/.config/.gitignore ~/
}

# ───────────────────────────────────────────────
# 4. Link Config (your preferred default)
# ───────────────────────────────────────────────
linkConfig() {
  echo -e "${CYAN}▶ Linking dotfiles${RC}"

  mv dotfiles ~/.dotfiles 2>/dev/null || true

  rm -rf ~/.config
  ln -svf ~/.dotfiles/config ~/.config

  ln -svf ~/.dotfiles/.npmrc ~/
  ln -svf ~/.dotfiles/.bashrc ~/
  ln -svf ~/.dotfiles/.bash_prompt ~/
  ln -svf ~/.dotfiles/.gitignore ~/
  cp ~/.dotfiles/.gitconfig ~/
}

# ───────────────────────────────────────────────
# 5. Git Config
# ───────────────────────────────────────────────
gitConfig() {
  echo -e "${CYAN}▶ Git configuration${RC}"

  read -p "Enter git username: " gitName
  read -p "Enter git email: " gitEmail

  git config --global user.name "$gitName"
  git config --global user.email "$gitEmail"
}

# ───────────────────────────────────────────────
# 6. pnpm Setup
# ───────────────────────────────────────────────
pnpmSetup() {
  echo -e "${CYAN}▶ Installing pnpm${RC}"
  npm install -g pnpm
  pnpm setup
  source ~/.bashrc
  pnpm install -g dotenv live-server nodemon sass
}

# ───────────────────────────────────────────────
# 7. Additional Setup
# ───────────────────────────────────────────────
additional() {
  echo -e "${CYAN}▶ Additional setup${RC}"

  chsh -s fish
  fish -c "restoressh"
  fish -c "vsbin"

  if command_exists termux-setup-storage; then
    echo -e "${CYAN}▶ Configuring Termux${RC}"
    rm -f ~/.termux/colors.properties
    rm -f ~/.termux/termux.properties

    cp ~/.dotfiles/termux/colors.properties ~/.termux/colors.properties
    cp ~/.dotfiles/termux/termux.properties ~/.termux/termux.properties

    curl -L \
      https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/JetBrainsMonoNLNerdFont-Regular.ttf \
      -o ~/.termux/font.ttf
  fi

  bat cache --build
  nvim --headless "+Lazy! sync" +qa

  gh auth login
}

# ───────────────────────────────────────────────
# 8. Suggestions
# ───────────────────────────────────────────────
suggestions() {
  echo -e "${GREEN}Done! Restart your shell to apply changes.${RC}"
  echo
  echo "Recommended:"
  echo "  npm install -g vscode-langservers-extracted"
  echo
}

# ───────────────────────────────────────────────
# Full Install
# ───────────────────────────────────────────────
run_full_install() {
  cloneRepo
  installPackages
  linkConfig
  gitConfig
  additional
  suggestions
}

# ───────────────────────────────────────────────
# Menu
# ───────────────────────────────────────────────
showMenu() {
  echo
  echo -e "${YELLOW}Select the functions to run (space-separated):${RC}"
  echo "  1) Clone repo"
  echo "  2) Install packages"
  echo "  3) Copy config"
  echo "  4) Link config"
  echo "  5) Git config"
  echo "  6) pnpm setup"
  echo "  7) Additional setup"
  echo "  8) Run full installation"
  echo "  0) Exit"
  echo
  read -p "Your choice: " choices

  for c in $choices; do
    case "$c" in
    1) cloneRepo ;;
    2) installPackages ;;
    3) copyConfig ;;
    4) linkConfig ;;
    5) gitConfig ;;
    6) pnpmSetup ;;
    7) additional ;;
    8) run_full_install ;;
    0) exit 0 ;;
    esac
  done
}

# ───────────────────────────────────────────────
# Start menu
# ───────────────────────────────────────────────
showMenu
