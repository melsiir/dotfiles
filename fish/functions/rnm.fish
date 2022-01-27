function rnm --wraps='rm -r node_modules' --description 'alias rnm=rm -r node_modules'
  rm -r node_modules $argv; 
end
