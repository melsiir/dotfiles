#!/data/data/com.termux/files/usr/bin/bash

# Prevent execution if this script was only partially downloaded
{
  RC='\033[0m'
  RED='\033[31m'
  YELLOW='\033[33m'
  CYAN='\033[36m'
  GREEN='\033[32m'
  BLUE='\033[34m'

  echo -e "${GREEN}Welcome from melsiir, I hope you find my dotfiles usefull${RC}"

  command_exists() {
    command -v "$1" >/dev/null 2>&1
  }

  installPackagesAndClone() {
    if command_exists termux-setup-storage; then
      termux-setup-storage
    fi

    echo -e "${GREEN}installing required packages...${RC}"
    packagesToInstall="git fish lua54 neovim fzf eza make cmake zip tree fd bat nodejs starship openssl-tool wget2 unzip unrar ripgrep iproute2 aria2 jq which"
    if command_exists pacman; then
      pacman -Syu
      pacman -S $packagesToInstall --noconfirm
      pacman -S gh --noconfirm
    else
      apt update && apt upgrade -y
      apt install -y $packagesToInstall
      apt install gh -y
    fi
    git clone https://github.com/melsiir/dotfiles
    chsh -s fish
  }

  # if you prefer copying dotfiles
  copyConfig() {
    cp --update=all ./dotfiles/. ~/.config/
    cp --update=all ~/.config/.npmrc ~/
    cp --update=all ~/.config/.gitignore ~/
  }

  # if you prefer linking dotfiles
  linkConfig() {
    echo -e "${GREEN}Linking the dotfiles...${RC}"
    mv dotfiles ~/.dotfiles
    rm -rf ~/.config
    ln -svf ~/.dotfiles/config ~/.config
    # ln -svf ~/.dotfiles/myvim ~/.config/nvim
    # ln -svf ~/.dotfiles/lazyvim ~/.config/nvim
    ln -svf ~/.dotfiles/.npmrc ~/
    ln -svf ~/.dotfiles/.bashrc ~/
    ln -svf ~/.dotfiles/.bash_prompt ~/
    ln -svf ~/.dotfiles/.gitignore ~/
    cp ~/.dotfiles/.gitconfig ~/
  }

  pnpmSetup() {
    echo -e "${GREEN}install pnpm...${RC}"
    npm install -g pnpm
    pnpm setup
    source ~/.bashrc
    pnpm install -g dotenv live-server nodemon sass
  }
  gitConfig() {
    echo -e "${GREEN}setting up git config${RC}"
    #if interactive
    if [[ -t 0 ]]; then
      read -p "Enter your name for git: " gitName
      read -p "Enter your email for git: " gitEmail

      git config --global user.name "$gitName"
      git config --global user.email "$gitEmail"
    else
      gitUserReminder() {
        echo -e "$RED please setup your git username and email by:"
        echo "git config --global user.name gitName"
        echo "git config --global user.email gitEmail"
      }
    fi
    # git config --global core.excludesfile ~/.gitignore
    # git config --global init.defaultBranch main
    # git config --global push.default upstream
    # git config --global credential.helper store
    # git config --global alias.l "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --decorate --date=short --color --decorate"
  }

  additional() {
    fish -c "restoressh"
    fish -c "vsbin"

    if command_exists termux-setup-storage; then
      # restoreTermux
      echo -e "${GREEN}configuring termux...${RC}"
      rm ~/.termux/colors.properties
      rm ~/.termux/termux.properties
      cp ~/.dotfiles/termux/colors.properties ~/.termux/colors.properties
      cp ~/.dotfiles/termux/termux.properties ~/.termux/termux.properties
      curl -L https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/JetBrainsMonoNLNerdFont-Regular.ttf -o font.ttf
      mv font.ttf ~/.termux/font.ttf
    fi
    # build custom bat themes
    bat cache --build

    nvim --headless "+Lazy! sync" +qa
    if [[ -t 0 ]]; then
      gh auth login
    fi
  }

  suggestions() {
    echo -e "${GREEN}Done! restart your shell to see the changes.${RC}"
    echo -e "${GREEN}Here is some usefull tips!${RC}"
    echo "some packages you may be intetested in"
    echo " pkg:"
    echo "   gh"
    echo " npm:"
    echo "   vscode-langservers-extracted"
    echo " if you lazy and don't want to sign in github everytime you push to repo"
    echo -e "\e[31m\e[1m Danger\e[0m credintials are saved in local text file"
    echo " git config --global credential.helper store"
    echo
    echo "open neovim so mason could downloaded needed language servers"
    if command_exists gitUserReminder; then
      gitUserReminder
      echo "login in to github cli:"
      echo "gh auth login"
    fi
  }

  installPackagesAndClone
  # copyConfig
  linkConfig
  pnpmSetup
  gitConfig
  additional
  suggestions
}
