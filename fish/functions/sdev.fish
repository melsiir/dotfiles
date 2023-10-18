function sdev --wraps='sudo npm run dev' --description 'alias sdev=sudo npm run dev'
  sudo npm run dev $argv; 
end
