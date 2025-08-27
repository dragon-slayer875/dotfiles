source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
NEWLINE=$'\n'
PROMPT="%B%F{185}%m%f%b@%F{215}%n%f %~ ${NEWLINE}%(?.%B%F{14}❯.%F{9}❯)%f%b "

# Exporting terminals
export TERM='kitty'
export TERMINAL='kitty'

# Autoload zsh's `add-zsh-hook` and `vcs_info` functions
# (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Set prompt substitution so we can use the vcs_info_message variable
setopt prompt_subst
# Run the `vcs_info` hook to grab git info before displaying the prompt
add-zsh-hook precmd vcs_info
# Style the vcs_info message
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%b%u%c'
# Format when the repo is in an action (merge, rebase, etc)
zstyle ':vcs_info:git*' actionformats '%F{14}⏱ %*%f'
zstyle ':vcs_info:git*' unstagedstr '*'
zstyle ':vcs_info:git*' stagedstr '+'
# This enables %u and %c (unstaged/staged changes) to work,
# but can be slow on large repos
zstyle ':vcs_info:*:*' check-for-changes true

# Set the right prompt to the vcs_info message
RPROMPT='⎇ ${vcs_info_msg_0_}'

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# History settings
HISTFILE=~/.histfile
HISTSIZE=20000
SAVEHIST=20000
setopt sharehistory

# Setting vim key bindings for zsh
bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename '/home/rudraksht/.zshrc'

fpath=(~/.zsh/zsh-completions/src $fpath)
zstyle ':completion:*' menu select
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
_comp_options+=(globdots) # include hidden files
# End of lines added by compinstall

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias sl="echo 'correcting to ls' && ls"
alias ls="eza --icons --color=auto --group-directories-first -a"
alias ll='eza --icons --group-directories-first -la'   # show long listing of all except ".."
alias icat="kitty +kitten icat"
alias ip="ip -o a"

# NVM configuration
export NVM_DIR="$HOME/.nvm"
# List of commands which require NVM to be loaded
local requires_nvm=(nvm node npm pnpm nvim)
for cmd in "${requires_nvm[@]}"
do
    "$cmd"() {
        # Remove this shim function
        unset -f "$0"
        # Load NVM
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
        # Run the now-loaded command
        "$0" "$@"
    }
done

# paths
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$PATH:/home/rudraksht/go/bin
export JAVA_HOME=/opt/android-studio/jbr
export ANDROID_HOME="$HOME/Android/Sdk"
export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$HOME/.cargo/bin:$PATH
export PATH="/home/rudraksht/.bun/bin:$PATH"
export PYTHONPATH=/usr/lib/python3.13:/usr/lib/python3.13/lib-dynload

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
