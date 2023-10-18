function rrnodemodules
find . -type d -name 'node_modules' -print0 | xargs -0 -I {} rm -rf "{}"
end
