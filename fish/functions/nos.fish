function nos --wraps='du -h node_modules' --description 'alias nos=du -h node_modules'
  du -h node_modules $argv; 
end
