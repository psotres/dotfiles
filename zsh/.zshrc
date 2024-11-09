# load functions
typeset -U fpath
my_functions=$HOME/.config/zsh/functions
if [[ -d $my_functions && $(find $my_functions -type f ! -name '.*' -print -quit) ]]; then
    # only load functions if there is something to load in the my_functions folder
    if [[ -d $my_functions && -n $(ls -A $my_functions) ]]; then
        if [[ -z ${fpath[(r)$my_functions]} ]] ; then
            fpath=($my_functions $fpath)
            autoload -Uz ${my_functions}/*(:t)
        fi
    fi
fi

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt append_history # append history to the history file (no overwriting)
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell
setopt hist_ignore_dups # do not store duplications
setopt hist_ignore_space # ignore duplicates when searching
setopt hist_save_no_dups
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items

# Use modern completion system
autoload -Uz compinit && compinit

# Enable hidden files completion
_comp_options+=(globdots)

# Enable menu selection and prevent auto cycling
zstyle ':completion:*' menu select

#zstyle ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
#zstyle ':completion:*' special-dirs '..'
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

# Customize menu appearance:
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true

# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

### FZF config

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# fzf parameters used in all widgets - configure layout and wrapped the preview results (useful in large command rendering)
# export FZF_DEFAULT_OPTS="--height 100% --layout reverse --preview-window=wrap"
export FZF_DEFAULT_OPTS="--height 40% --tmux bottom,40% --layout reverse --border top"

# CTRL + R: put the selected history command in the preview window - "{}" will be replaced by item selected in fzf execution runtime
# export FZF_CTRL_R_OPTS="--preview 'echo {}'"

# CTRL + T: set "fd-find" as search engine instead of "find" and exclude contents from the results
export FZF_CTRL_T_COMMAND="fd -H --ignore-file $HOME/.config/zsh/.fd-fzf-ignore"

# CTRL + T: put the file content if item select is a file, or put tree command output if item selected is directory
export FZF_CTRL_T_OPTS="--preview '[ -d {} ] && tree -C -ad -L 3 {} || bat --color=always --style=numbers --line-range=:500 {}'"

# ALT + C: put the tree command output based on item selected
export FZF_ALT_C_OPTS="--preview 'tree -C -ad -L 3 {}'"


### KEY BINDINGs

# bindkey tip: to discovery the code of your keys, execute "$ cat -v" and press the key,
# the code will be printed in your shell.

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# navigate words using Ctrl + arrow keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# usual mappings for "page up" and "page down" to search the history (same command, use Ctrl + r for fzf)
bindkey "^[[5~" history-search-backward
bindkey "^[[6~" history-search-forward

# To be used with history-substring-search plugin
# bindkey "^[[5~" history-substring-search-up
# bindkey "^[[6~" history-substring-search-down


### ALIASES

# Colorize basic commands (ls, grep, ...)
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Use "bat" as manpager with colors
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# fzf with "selective" preview
alias fzfp="fzf --preview '[ -d {} ] && tree -C {} || bat --color=always --style=numbers --line-range=:500 {}'"

alias ll="ls -alh"
alias rm="rm -i"


ZSH_PLUGINS="$HOME/.config/zsh/plugins"

source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGINS/zsh-you-should-use/you-should-use.plugin.zsh"
source "$ZSH_PLUGINS/ohmyzsh/plugins/sudo/sudo.plugin.zsh"
source "$ZSH_PLUGINS/ohmyzsh/plugins/dirhistory/dirhistory.plugin.zsh"
source "$ZSH_PLUGINS/ohmyzsh/lib/clipboard.zsh"
source "$ZSH_PLUGINS/ohmyzsh/plugins/copybuffer/copybuffer.plugin.zsh"
source "$ZSH_PLUGINS/ohmyzsh/plugins/copypath/copypath.plugin.zsh"
source "$ZSH_PLUGINS/ohmyzsh/plugins/copyfile/copyfile.plugin.zsh"
source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

### PROMPT

if [ -z "${TMUX}" ]; then
    # not tmux
    eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/pso3g.omp.yaml)"
else
    # tmux
    eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/pso3g-tmux.omp.yaml)"
fi
