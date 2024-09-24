> [!TIP]
> termux tmp directory is
> $TMPDIR
> in case you want to use it in scripts

# customiziation

# get prompt samples

fish_config prompt show

# you can use fish_config

prompt save <prompt-name> to save the prompt.

# check if sring contain substring

```fish
set y "help"
  set z "i am asking for help"
 if   echo $z|grep -q $y
   echo "yes"
 else
   echo "no"
 end  

```

# print all the arguments from the second to the last

`echo $argv[2..-1]`

# extract the id from html or svg file

```fish
 sift -m --only-matching 'id(="(.*?)")' file.svg | sed 's/id="//g' | sed 's/\"//g');
```

dracula theme for fzf run it on time in fish shell

set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

or add it to bashrc

export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# check if command nvim executable: if command -qs nvim

# check if command nvim not executable: if not command -qs nvim

Special variables
Some bash variables and their closest fish equivalent:

$*, $@, $1 and so on: $argv

$?: $status

$$: $fish_pid

$#: No variable, instead use count $argv

$!: $last_pid

$0: status filename

$-: Mostly status is-interactive and status is-login

# get pid for proccess ex

echo hi | echo $last_pid

Reading a File with Fish
To gracefully read a file line by line in Fish, employ the read builtin.

while read -la line
    echo $line
end < my_file

Create a file in the home with the name `.fish_variables`
and call in it `set -xU VAR_NAME VAR_VAULE`
to set secret values in fish env.
