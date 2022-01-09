function css --wraps=echo\ \'\*\ \{\n\ \ \n\}\n\n\'\ \>\>\ style.css --description alias\ css=echo\ \'\*\ \{\n\ \ \n\}\n\n\'\ \>\>\ style.css
  echo '* {
  
}

' >> style.css $argv; 
end
