function bfish
  if test -d $HOME/storage/downloads/fish
    rm -r $HOME/storage/downloads/fish
  end
  cp -r $HOME/.config/fish $HOME/storage/downloads/fish
end
