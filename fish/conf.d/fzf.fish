# fzf.fish is only meant to be used in interactive mode. If not in interactive mode and not in CI, skip the config to speed up shell startup
if not status is-interactive && test "$CI" != true
    exit
end

# Because of scoping rules, to capture the shell variables exactly as they are, we must read
# them before even executing _fzf_search_variables. We use psub to store the
# variables' info in temporary files and pass in the filenames as arguments.
# This variable is global so that it can be referenced by fzf_configure_bindings and in tests
set --global _fzf_search_vars_command '_fzf_search_variables (set --show | psub) (set --names | psub)'

# set -l color00 '#292D3E'
# set -l color01 '#444267'
# set -l color02 '#32374D'
# set -l color03 '#676E95'
# set -l color04 '#8796B0'
# set -l color05 '#959DCB'
# set -l color06 '#959DCB'
# set -l color07 '#FFFFFF'
# set -l color08 '#F07178'
# set -l color09 '#F78C6C'
# set -l color0A '#FFCB6B'
# set -l color0B '#C3E88D'
# set -l color0C '#89DDFF'
# set -l color0D '#82AAFF'
# set -l color0E '#C792EA'
# set -l color0F '#FF5370'

# set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --border --height 90% --preview-window=right:70% \
#     --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D \
#     --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C \
#     --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

# Install the default bindings, which are mnemonic and minimally conflict with fish's preset bindings
fzf_configure_bindings

# Doesn't erase autoloaded _fzf_* functions because they are not easily accessible once key bindings are erased
function _fzf_uninstall --on-event fzf_uninstall
    _fzf_uninstall_bindings

    set --erase _fzf_search_vars_command
    functions --erase _fzf_uninstall _fzf_migration_message _fzf_uninstall_bindings fzf_configure_bindings
    complete --erase fzf_configure_bindings

    set_color cyan
    echo "fzf.fish uninstalled."
    echo "You may need to manually remove fzf_configure_bindings from your config.fish if you were using custom key bindings."
    set_color normal
end
