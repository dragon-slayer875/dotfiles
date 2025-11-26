source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
NEWLINE=$'\n'
PROMPT="%B%F{185}%m%f%b@%F{215}%n%f %~ ${NEWLINE}%(?.%B%F{14}❯.%F{9}❯)%f%b "

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

# History settings
HISTFILE=~/.histfile
HISTSIZE=20000
SAVEHIST=20000
setopt sharehistory

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
alias sl="echo 'correcting to ls' && ls"
alias ls="eza --icons --color=auto --group-directories-first -a"
alias ll='eza --icons --group-directories-first -la'   # show long listing of all except ".."
alias icat="kitty +kitten icat"
alias ip="ip -c -o a"
alias nvim-astro='NVIM_APPNAME="nvim-astro" nvim'

mkcd() {
       mkdir -p "$1" && cd "$1"
   }

# Setting key bindings for zsh
bindkey -v
bindkey '^ ' autosuggest-accept


# fnm config
# List of commands which require fnm to be loaded
local requires_nvm=(fnm node npm pnpm nvim)
for cmd in "${requires_nvm[@]}"
do
    "$cmd"() {
        # Remove this shim function
        unset -f "$0"
        eval "$(fnm env --use-on-cd --shell zsh)"
        # Run the now-loaded command
        "$0" "$@"
    }
done

rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
