function cleanPnpm --wraps='pnpm store prune' --description 'alias cleanPnpm=pnpm store prune'
  pnpm store prune $argv; 
end
