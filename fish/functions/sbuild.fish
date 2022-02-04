function sbuild --wraps='sudo npm run build' --description 'alias sbuild=sudo npm run build'
  sudo npm run build $argv; 
end
