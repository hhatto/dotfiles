export PATH=/usr/local/bin:$PATH

source $HOME/.zsh/zsh-completion-generator/zsh-completion-generator.plugin.zsh

fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(~/.zsh/completions/ $fpath)
autoload -U /usr/local/share/zsh-completions/*(:t)
autoload -U ~/.zsh/completions/*(:t)
autoload -Uz compinit
compinit -u

setopt prompt_subst
zstyle ':completion:*' use-cache yes
local GREEN=$'%{\e[1;38;5;202m%}'
local PINK=$'%{\e[1;38;5;198m%}'
local LGREEN=$'%{\e[1;38;5;149m%}'
local YELLOW=$'%{\e[1;38;5;33m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULTNON=$'%{\e[1;0m%}'
local DEFAULT=$'%{\e[1;38;5;152m%}'
autoload -Uz vcs_info
# zstyle ':vcs_info:bzr:*' use-simple true
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    if [ -e ./Cargo.toml ]; then
        PROMPT_RUSTC_VERSION=" rust:"$BLUE`rustc --version | awk '{ print $2 }'`$DEFAULTNON
    else
        PROMPT_RUSTC_VERSION=""
    fi
}
PROMPT='[%D.%T]'$GREEN'%n@%m: '$YELLOW'%(5~,%-2~/../%2~,%~) '$DEFAULTNON'%1(v|'$LGREEN'%1v%f|)'$DEFAULTNON'$PROMPT_RUSTC_VERSION'$'\n'$DEFAULTNON'%(!.#.$) '

export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

bindkey "" history-incremental-search-backward

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=100000
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt extended_history

export LOCALE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export CONFIG_NAME=_test

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>+"
export EDITOR=/usr/local/bin/vim
export PYTHONSTARTUP=$HOME/.pythonrc
source $HOME/.zsh/plugins/*

# simple zsh completion
compdef _gnu_generic flake8 pep8 autopep8 ansible jubaanomaly jubaclassifier jubagraph jubarecommender jubaregression jubastat

# for substring-search
source /usr/local/Cellar/zsh-history-substring-search/1.0.1/zsh-history-substring-search.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
for keycode in '[' 'O'; do
  bindkey "^[${keycode}A" history-substring-search-up
  bindkey "^[${keycode}B" history-substring-search-down
done
unset keycode

# for Go lang
export GOROOT=`go env GOROOT`
export GOPATH=$HOME/.golang
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# for virtualenv and virtualenvwrapper
source /usr/local/bin/virtualenvwrapper_lazy.sh

# for Rust
source $HOME/.cargo/env
export PATH=$PATH:$HOME/.multirust/toolchains/stable/cargo/bin:$HOME/.multirust/toolchains/nightly/cargo/bin
export RUST_SRC_PATH=$HOME/.ghq/github.com/rust-lang/rust/src

# local settings
source $HOME/.alias
source $HOME/.localrc

if (which zprof > /dev/null) ;then
  zprof | less
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
