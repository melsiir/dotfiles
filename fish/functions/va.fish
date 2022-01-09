function va --wraps='vi index.html style.css main.js' --description 'alias va=vi index.html style.css main.js'
  vi index.html style.css main.js $argv; 
end
