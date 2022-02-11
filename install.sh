#!/bin/bash



installAll ()
{
  echo "install neccassry packages ....."
  pkg update && pkg upgrade
  pkg install neovim nodejs clang make ripgrep python glow fish zip rsync tsu openssh tree curl exa
 
  echo "Install Config and font ......"
 cp -Rvup ./nvim/. $HOME/.config/nvim/
 cp -Rvup ./fish/. $HOME/.config/fish/
 cp -p ./Fonts/jetbrain-mono.ttf $HOME/.termux/font.ttf

   echo "Install language servers and formaters ......"
  npm install -g typescript-language-server  typescript vscode-langservers-extracted pyright @tailwindcss/language-server graphql-language-service-cli @fsouza/prettierd;
  pip install --upgrade pip
  pip install black
  echo "install install essensial node development tools ........."
  pnpm install -g dotenv lite-server live-server nodemon esm;

}


installConfigs() {
  echo "Do you want to install nvim config type y or Y to eccept ?"
  read -r nvim
  echo "Do you want to install fish config type y or Y to eccept?"
  read -r fish
  if [[ $nvim == "y" || $nvim == "Y" ]]; then
    cp -Rvup ./nvim/. $HOME/.config/nvim/
  else
    true
  fi
  
  if [[ $fish == "y" || $fish == "Y" ]]; then
    echo "Do you want to install fish and set it as your default shell ? y, n"  
    read -r installFish
    if [[ $installFish == "y" || $installFish == "Y" ]]; then
      pkg install fish 
      chsh -s fish
    fi
     cp -Rvup ./fish/. $HOME/.config/fish/
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
  echo "[ * ] Neovim"
  echo "[ * ] Nodejs"
  echo "[ * ] Clang"
  echo "[ * ] Make"
  echo "[ * ] ripgrep"
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
    echo "[ * ] zip"
    echo "[ * ] tsu"
    echo "[ * ] rsync"
    echo "[ * ] openssh"
    echo "[ * ] tree"
    echo "[ * ] curl"
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
  echo "[ * ] typescript-language-server"
  echo "[ * ] typescript"
  echo "[ * ] vscode-langservers-extracted"
  echo "[ * ] @tailwindcss/language-server"
  echo "[ * ] prettierd"
  echo "[ * ] pyright"
  echo "[ * ] graphql-language-service-cli"
  echo "[ * ] lua-language-server"
  read -r lsp
  if [[ $lsp == "y" ]]; then
    npm install -g typescript-language-server  typescript vscode-langservers-extracted pyright @tailwindcss/language-server graphql-language-service-cli @fsouza/prettierd;
    pkg install lua-language-server;
  else
    true
  fi
}

webdiv ()
{
  echo "do you want to install web development tool with pnpm ? (y, n)"
  echo "[ * ] dotenv"
  echo "[ * ] lite-server"
  echo "[ * ] live-server"
  echo "[ * ] nodemon"
  echo "[ * ] esm"
  read -r web
  if [[ $web == "y" ]]; then
    pnpm install -g dotenv lite-server live-server nodemon esm;
  else
    true
  fi
}

font () {
  echo "Do you want to install nerd fonts ? (y, n) :"
  read -r fon 
  if [[ $fon == "y" ]]; then
  echo "choose your font :"
  echo "[ 1 ] Jetbrain Mono"
  echo "[ 2 ] Fira Mono"
  echo "[ 3 ] Hack"
  echo "[ 4 ] Noto Mono"
  read -r num

  if [[ $num > 0 || $num < 5 ]]; then 
    mv $HOME/.termux/font.ttf $HOME/.termux/font.ttf.bak
    if [[ $num == 1 ]]; then
      cp -p ./Fonts/jetbrain-mono.ttf $HOME/.termux/font.ttf
    elif [[ $num == 2 ]]; then
      cp -p ./Fonts/fira.ttf $HOME/.termux/font.ttf
    elif [[ $num == 3 ]]; then
      cp ./Fonts/hack.ttf $HOME/.termux/font.ttf
    elif [[ $num == 4 ]]; then
      cp ./Fonts/noto.ttf $HOME/.termux/font.ttf
    fi
  fi 
 fi
}

checkIfUseTermux () {
  D=$PWD

if [[ "$D" =~ .*"termux".* ]]; then
  termux-setup-storage
fi
}

startNeovim ()
{
   echo "do you want to launch nvim ? (y, n)"
   read -r launch
   if [[ $launch == "y" || $launch == "Y" ]]; then
     nvim +'hi NormalFloat guibg=#1e222a' +PackerSync 
   else
    true
   fi 
}



#funcions envoking

installPackages
checkIfUseTermux
installConfigs
font
lsp
webdiv 



# installMethod ()
# {
#   echo "choose Installation type:"
#   echo "[ 1 ] full install"
#   echo "[ 2 ] custom install"
#   read -r insType
#   if [[ insType == "1" ]]; then
#     $(installAll)
#   elif [[ insType == "2" ]]; then
#     $(installCustom)
#   fi
# }

# installMethod

startNeovim
