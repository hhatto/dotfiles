set fish_color_command normal

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# go
set -x PATH $HOME/go/bin $PATH
set -x GOROOT "$(go env GOROOT)"
set -x PATH $GOROOT/bin $PATH

# nodenv
# eval "$(nodenv init -)"
# set -x PATH $HOME/.nodenv/versions/20.11.1/bin/bin $PATH  # TODO: fix this path

# pyenv
# set -x PYENV_ROOT $HOME/.pyenv
# set -x PATH $PYENV_ROOT/bin $PATH
# set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
# pyenv init - | source

if status is-interactive
    source $HOME/.alias
    export LSCOLORS=gxfxcxdxbxegedabagacad
end

# for mise
# $HOME/.local/bin/mise activate fish | source
# fish_add_path ~/.local/share/mise/shims

# fish_add_path -a ~/.foundry/bin

# pnpm
# set -gx PNPM_HOME "$HOME/Library/pnpm"
# if not string match -q -- $PNPM_HOME $PATH
#   set -gx PATH "$PNPM_HOME" $PATH
# end
# pnpm end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# set --export --prepend PATH "$HOME/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
