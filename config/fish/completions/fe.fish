

function __fe_entries
    functions | string replace "," "\n"
end

complete -f -c fe -a '(__fe_entries)'
