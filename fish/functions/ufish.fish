function ufish --wraps='rsync -aupP --progress --delete /data/data/com.termux/files/home/.config/fish/ /data/data/com.termux/files/home/.config/dotfiles/fish' --description 'alias ufish=rsync -aupP --progress --delete /data/data/com.termux/files/home/.config/fish/ /data/data/com.termux/files/home/.config/dotfiles/fish'
  rsync -aupP --progress --delete /data/data/com.termux/files/home/.config/fish/ /data/data/com.termux/files/home/.config/dotfiles/fish $argv; 
end
