if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"
  local return_status="%{$fg[red]%}%(?..⏎ )%{$reset_color%}"
  local user="[%{$fg[yellow]%}%n@%{$fg[green]%}%m%{$reset_color%}]"
  local pwd='%{$fg[cyan]%}%~%{$reset_color%}'
  local git_branch='$(git_prompt_info)%{$reset_color%} $(git_prompt_status)%{$reset_color%}'

  PROMPT="${user} ${pwd}${git_branch}
%(!.%{$fg_bold[red]%}#.%{$fg_bold[green]%}❯)%{$reset_color%} ${return_status}"

  ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[magenta]%}\uE0A0%{$reset_color%} %{$fg_bold[magenta]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  RPROMPT='${return_status}$(git_prompt_status)%{$reset_color%}'

  ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[red]%}+"
  ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}!"
  ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}x"
  ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[red]%}➜"
  ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}═"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}?"
else
  MODE_INDICATOR="❮❮❮"
  local return_status="%(?::⏎)"

  PROMPT='%c$(git_prompt_info) %(!.#.❯) '

  ZSH_THEME_GIT_PROMPT_PREFIX=" git:"
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  RPROMPT='${return_status}$(git_prompt_status)'

  ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
  ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
  ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
  ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
  ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
fi
