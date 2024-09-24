#!/bin/bash

# back old config

installPackagesAndClone() {
  # mkdir -p ~/migration/home/
  # cp -rp ~/.config ~/migration/home

  D=$HOME

  if [[ "$D" =~ .*"termux".* ]]; then
    termux-setup-storage
  fi

  apt update && apt upgrade -y
  apt install git -y
  git clone https://github.com/melsiir/dotfiles

  apt install -y fish lua54 neovim fzf eza make cmake zip tree fd bat nodejs starship openssl-tool wget2 unzip unrar ripgrep

}

copyConfig() {
  mv dotfiles .dotfiles
  # mkdir -p ~/.config
  # cp --update=all ./dotfiles/. ~/.config/
  # cp --update=all ~/.config/.npmrc $HOME
  # cp --update=all ~/.config/.gitignore $HOME
  ## linking files
  ln -sfr ~/.dotfiles/config ~/.config/
  ln -sf ~/dotfile/npmrc ~/.npmrc
  ln -sf ~/.dotfiles/gitignore ~/.gitignore

  chsh -s fish

  npm install -g pnpm

  # pnpm setup
  pnpm setup
  source ~/.bashrc

  pnpm install -g dotenv live-server nodemon sass

  # fish -c "restoressh;vsbin"
  fish -c "vsbin"

  if [[ "$D" =~ .*"termux".* ]]; then
    restoreTermux
  fi

  # rm -rf ./dotfiles
}
# back old config

suggestions() {
  echo
  echo "some packkages you may be intetested in"
  echo " apt:"
  echo
  echo "     gh"
  echo
  echo " npm:"
  echo
  echo "     vscode-langservers-extracted"
}

gitConfig() {
  git config --global core.excludesfile ~/.gitignore
  git config --global init.defaultBranch main

}

installPackagesAndClone
copyConfig
gitConfig
suggestions
