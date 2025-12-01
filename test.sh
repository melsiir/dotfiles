#!/data/data/com.termux/files/usr/bin/bash

{
  ###############################################################################
  # COLORS
  ###############################################################################
  RC='\033[0m'
  RED='\033[31m'
  GREEN='\033[32m'
  YELLOW='\033[33m'
  CYAN='\033[36m'
  BLUE='\033[34m'
  BOLD='\033[1m'

  ###############################################################################
  # UTILITIES
  ###############################################################################
  command_exists() { command -v "$1" >/dev/null 2>&1; }

  ask() {
    read -p "$1 [Y/n]: " ans
    case "$ans" in
    n | N) return 1 ;;
    *) return 0 ;;
    esac
  }

  header() {
    echo -e "\n${CYAN}${BOLD}▶ $1${RC}\n"
  }

  ok() {
    echo -e "${GREEN}[✔]${RC} $1"
  }

  ###############################################################################
  # PROFESSIONAL PROGRESS BAR
  ###############################################################################
  progress() {
    local duration=$1
    local width=40
    local percent=0
    local filled=0

    echo -ne "${CYAN}[                                        ] 0%${RC}"

    for ((i = 0; i <= duration; i++)); do
      sleep 0.05
      percent=$((100 * i / duration))
      filled=$((width * i / duration))

      bar=$(printf "%-${width}s" "#" | sed "s/ /#/g")
      bar="${bar:0:filled}$(printf "%$((width - filled))s")"

      echo -ne "\r${CYAN}[${GREEN}${bar}${CYAN}] ${percent}%${RC}"
    done

    echo
  }

  ###############################################################################
  # INSTALLER FUNCTIONS
  ###############################################################################

  installPackagesAndClone() {
    header "Installing packages & cloning dotfiles"
    progress 40

    if command_exists termux-setup-storage; then
      ask "Run termux-setup-storage?" && termux-setup-storage
    fi

    apt update -y
    apt install -y git

    ask "Clone dotfiles repository?" && git clone https://github.com/melsiir/dotfiles

    packages="git fish lua54 neovim fzf eza make cmake zip tree fd bat nodejs starship openssl-tool wget2 unzip unrar ripgrep iproute2 aria2 jq which"

    if ask "Install required packages?"; then
      if command_exists pacman; then
        pacman -Syu --noconfirm
        pacman -S $packages --noconfirm
        pacman -S gh --noconfirm
      else
        apt update && apt upgrade -y
        apt install -y $packages gh
      fi
    fi

    ok "Package installation complete"
  }

  copyConfig() {
    header "Copying dotfiles"
    progress 15
    cp --update=all ./dotfiles/. ~/.config/
    cp --update=all ~/.config/.npmrc ~/
    cp --update=all ~/.config/.gitignore ~/
    ok "Copied configuration files"
  }

  linkConfig() {
    header "Linking dotfiles"
    progress 20
    mv dotfiles ~/.dotfiles
    rm -rf ~/.config
    ln -svf ~/.dotfiles/config ~/.config
    ln -svf ~/.dotfiles/.npmrc ~/
    ln -svf ~/.dotfiles/.bashrc ~/
    ln -svf ~/.dotfiles/.bash_prompt ~/
    ln -svf ~/.dotfiles/.gitignore ~/
    cp ~/.dotfiles/.gitconfig ~/
    ok "Linked dotfiles"
  }

  pnpmSetup() {
    header "Setting up pnpm"
    progress 15
    npm install -g pnpm
    pnpm setup
    source ~/.bashrc
    pnpm install -g dotenv live-server nodemon sass
    ok "pnpm setup complete"
  }

  gitConfig() {
    header "Configuring Git"
    progress 10

    if [[ -t 0 ]]; then
      read -p "Enter Git username: " gitName
      read -p "Enter Git email: " gitEmail
      git config --global user.name "$gitName"
      git config --global user.email "$gitEmail"
    else
      echo -e "${YELLOW}Skipping Git setup (non-interactive mode)${RC}"
    fi

    ok "Git configuration complete"
  }

  additional() {
    header "Running additional setup"
    progress 30

    ask "Change shell to fish?" && chsh -s fish

    ask "Run fish restore commands?" && {
      fish -c "restoressh"
      fish -c "vsbin"
    }

    if command_exists termux-setup-storage; then
      if ask "Apply Termux appearance & font?"; then
        rm ~/.termux/colors.properties 2>/dev/null
        rm ~/.termux/termux.properties 2>/dev/null
        cp ~/.dotfiles/termux/colors.properties ~/.termux/colors.properties
        cp ~/.dotfiles/termux/termux.properties ~/.termux/termux.properties
        curl -L https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/JetBrainsMonoNLNerdFont-Regular.ttf -o ~/.termux/font.ttf
      fi
    fi

    ask "Build bat themes?" && bat cache --build
    ask "Run Neovim Lazy sync?" && nvim --headless "+Lazy! sync" +qa
    ask "Login to GitHub CLI?" && gh auth login

    ok "Additional setup complete"
  }

  suggestions() {
    header "Installation finished!"
    echo -e "${GREEN}Restart your shell to apply changes.${RC}"
    echo -e "${CYAN}Useful tips:${RC}"
    echo "- Open Neovim to allow Mason to install language servers."
    echo "- Useful npm package: vscode-langservers-extracted"
    echo "- Run: gh auth login"
  }

  ###############################################################################
  # MENU SYSTEM
  ###############################################################################

  run_default() {
    installPackagesAndClone
    linkConfig
    gitConfig
    additional
    suggestions
  }

  run_selective() {
    header "Choose tasks to run"
    echo "1) Install packages & clone repo"
    echo "2) Copy config"
    echo "3) Link config"
    echo "4) Setup pnpm"
    echo "5) Configure Git"
    echo "6) Additional setup"
    echo "7) Run everything"
    echo "0) Exit"
    echo

    read -p "Enter choices (e.g. 1 3 6): " choices

    for c in $choices; do
      case $c in
      1) installPackagesAndClone ;;
      2) copyConfig ;;
      3) linkConfig ;;
      4) pnpmSetup ;;
      5) gitConfig ;;
      6) additional ;;
      7) run_default ;;
      0) exit 0 ;;
      esac
    done

    suggestions
  }

  ###############################################################################
  # MAIN
  ###############################################################################

  clear
  echo -e "${GREEN}${BOLD}Welcome to melsiir's Professional Installer${RC}"
  echo -e "${CYAN}A complete interactive Termux/Linux setup assistant${RC}\n"

  # Non-interactive mode → run everything
  if [[ ! -t 0 ]]; then
    echo -e "${YELLOW}Non-interactive mode detected. Running default installation.${RC}"
    run_default
    exit
  fi

  echo "Choose installation mode:"
  echo "1) Full installation (recommended)"
  echo "2) Select tasks manually"
  echo "0) Exit"
  echo

  read -p "Choice: " mode
  case "$mode" in
  1) run_default ;;
  2) run_selective ;;
  0) exit ;;
  *) run_default ;;
  esac

} # END SAFE-WRAPPED BLOCK
