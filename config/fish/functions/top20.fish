function top20 --wraps='du -ha | sort -k1hr | head -n 20' --description 'alias top20=du -ha | sort -k1hr | head -n 20'
  du -ha | sort -k1hr | head -n 20 $argv; 
end
