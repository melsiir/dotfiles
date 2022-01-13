function download --wraps='cp -r /storage/emulated/0/Download/termux/.' --description 'alias download=cp -r /storage/emulated/0/Download/termux/.'
  cp -r /storage/emulated/0/Download/termux/. $argv; 
end
