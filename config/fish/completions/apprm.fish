

function __offlineApp_entries
    grep -oE 'set \w+' ~/.config/fish/onDemand/packages.fish | string replace -r "set variable_name|set libs|set " ""
end

#uninstall completion
complete -f -c apprm -a '(__offlineApp_entries)'
