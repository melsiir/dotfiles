#!/bin/bash

install() {
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
    echo "nothing installed"
  else  
  echo "configs installed successfully"
  fi
}



install



