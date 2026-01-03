function gcm --wraps='git commit -m' --description 'alias gcm=git commit -m'
    git add .
    git commit -m $argv

end
