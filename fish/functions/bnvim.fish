function bnvim
  if test -d $HOME/storage/downloads/nvim
    rm -r $HOME/storage/downloads/nvim
  end
  cp -r $HOME/.config/nvim $HOME/storage/downloads/nvim
end
