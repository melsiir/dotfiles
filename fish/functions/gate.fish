function gate --wraps='rsync -avuP --chmod=g-rw --chown=u0_a300:u0_a300 --progress /storage/emulated/0/Download/termux/. ./' --description 'alias gate=rsync -avuP --chmod=g-rw --chown=u0_a300:u0_a300 --progress /storage/emulated/0/Download/termux/. ./'
  rsync -avuP --chmod=g-rw --chown=u0_a300:u0_a300 --progress /storage/emulated/0/Download/termux/. ./ $argv; 
end
