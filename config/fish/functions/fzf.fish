# bind \cr '__fzf_history'
bind -M insert \ch __fzf_tldr
bind -M insert \ct __fzf_files

set -l color00 '#292D3E'
set -l color01 '#444267'
set -l color02 '#32374D'
set -l color03 '#676E95'
set -l color04 '#8796B0'
set -l color05 '#959DCB'
set -l color06 '#959DCB'
set -l color07 '#FFFFFF'
set -l color08 '#F07178'
set -l color09 '#F78C6C'
set -l color0A '#FFCB6B'
set -l color0B '#C3E88D'
set -l color0C '#89DDFF'
set -l color0D '#82AAFF'
set -l color0E '#C792EA'
set -l color0F '#FF5370'

set -l layout "--cycle --layout=reverse --border  --preview-window=right:70% "


#set -x FZF_DEFAULT_OPTS "$layout \
#    --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D \
#    --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C \
#    --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

# export FZF_DEFAULT_OPTS="--reverse \
#     --preview-window=right,55%,border-sharp,nocycle \
#     --pointer=→ \
#     --prompt=/\  \
#     --marker=+\  \
#     --info=inline-right \
#     --no-separator \
#     --no-scrollbar \
#     --border=none \
#     --margin=1,0,0 \
#     --multi \
#     --ansi \
#     --color=fg:-1,bg:-1,hl:bold:cyan \
#     --color=fg+:-1,bg+:-1,hl+:bold:cyan \
#     --color=border:white,preview-border:white \
#     --color=marker:bold:cyan,prompt:bold:red,pointer:bold:red \
#     --color=gutter:-1,info:bold:red,spinner:cyan,header:white \
#     --bind=ctrl-k:kill-line \
#     --bind=alt-a:toggle-all \
#     --bind=alt-{:first,alt-}:last"


# set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --border  --preview-window=right:70% \
# --color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7 \
# --color=fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff \
# --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
# --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"


#dracula theme
# set -x FZF_DEFAULT_OPTS "$layout --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# another nice fzf themes


# set -x FZF_DEFAULT_OPTS "$layout --color=bg+:-1,\
# fg:gray,\
# fg+:white,\
# border:black,\
# spinner:0,\
# hl:yellow,\
# header:blue,\
# info:green,\
# pointer:red,\
# marker:blue,\
# prompt:gray,\
# hl+:red"

set -x FZF_DEFAULT_OPTS "$layout --color=bg+:-1,\
fg:gray,\
fg+:white,\
border:gray,\
spinner:0,\
hl:blue,\
header:blue,\
info:green,\
pointer:blue,\
marker:blue,\
prompt:gray,\
hl+:magenta"

# oceanicnext 
# set -l color00 '#1b2b34'
# set -l color01 '#343d46'
# set -l color02 '#4f5b66'
# set -l color03 '#65737e'
# set -l color04 '#a7adba'
# set -l color05 '#c0c5ce'
# set -l color06 '#cdd3de'
# set -l color07 '#d8dee9'
# set -l color08 '#ec5f67'
# set -l color09 '#f99157'
# set -l color0A '#fac863'
# set -l color0B '#99c794'
# set -l color0C '#5fb3b3'
# set -l color0D '#6699cc'
# set -l color0E '#c594c5'
# set -l color0F '#ab7967'
#
# set -x FZF_DEFAULT_OPTS "$layout  \
#      --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D\
#  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C\
#  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
