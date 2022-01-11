function ppmi --wraps='pnpm init -y' --wraps='pnpm init' --description 'alias ppmi=pnpm init'
  pnpm init $argv; 
end
