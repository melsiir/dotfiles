function gpom --wraps='git push -u origin main' --description 'alias gpom=git push -u origin main'
  git push -u origin main $argv; 
end
