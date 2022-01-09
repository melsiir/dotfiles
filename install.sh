#!/bin/bash

installConfigs() {
  echo "Do you want to install nvim config type y or Y to eccept ?"
  read -r nvim
  echo "Do you want to install fish config type y or Y to eccept?"
  read -r fish
  if [[ $nvim == "y" || $nvim == "Y" ]]; then
    cp -Rvup ./nvim/ $HOME/.config/nvim/
  else
    true
  fi
  
  if [[ $fish == "y" || $fish == "Y" ]]; then
     cp -Rvup ./fish/ $HOME/.config/fish/
  else
    true
  fi

   if [[ $fish != "y" && $nvim != "y" ]]; then
    echo "no config installed"
  else  
  echo "configs installed successfully"
  fi
}


 installPackages ()
{
  echo "Do you want to install neccassry linux packages (y or n) ?"
  read -r pkg
  if [[ $pkg == "y" ]]; then
    pkg update && pkg upgrade;
    echo "following packages will be installed: \n  node clang \n make ripgrep !"
    pkg install neovim nodejs clang make ripgrep;


    echo "Do you want to install python ? (y , n)"
    read -r python
    if [[ $python == "y" ]]; then
      pkg install python;
      echo "installing python formatter"
      pip install black
    else
      true
    fi


    echo "do you want to install glow ?"
    read -r glow
    if [[ $glow == "y" ]]; then
      pkg install glow
    else
        true
    fi


    echo "Do you want install some essensial packages ? ( y, n)"
    read -r essensial
    if [[ $essensial == "y" ]]; then
      pkg install zip rsync tsu openssh tree curl
      else
        true
    fi


  else
    true
  fi
}

lsp ()
{
  echo "Do you want to install language servers ? (y, n)"
  read -r lsp
  if [[ $lsp == "y" ]]; then
    npm install -g typescript-language-server  typescript vscode-langservers-extracted pyright @tailwindcss/language-server graphql-language-service-cli @fsouza/prettierd
  else
    true
  fi
}

webdiv ()
{
  echo "do you want to install web development tool with pnpm ? (y, n)"
  read -r web
  if [[ $web == "y" ]]; then
    pnpm i -g dotenv lite-server live-server nodemon esm;
  else
    true
  fi
}




installPackages
installConfigs
lsp
webdiv


nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
