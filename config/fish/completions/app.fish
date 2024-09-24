# completion for my offline repo installer
# in ~/.config/fish/onDemand/offline.fish

function __offlineApp_entries
    grep -oE 'set \w+' ~/.config/fish/onDemand/packages.fish | string replace -r "set variable_name|set libs|set " ""
end

complete -f -c app -a '(__offlineApp_entries)'
