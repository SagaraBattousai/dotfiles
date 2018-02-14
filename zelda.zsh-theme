if [ "$USER" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="magenta"; fi
if [ "$USER" = "root" ]; then USERCOLOR="red"; else USERCOLOR="blue"; fi

local return_code="%(?..%{$fg_bold[red]%}:( %?%{$reset_color%})"

PROMPT='
%{$fg_bold[yellow]%} ▲ %{$reset_color%}%{${fg[$USERCOLOR]}%}%n%{$reset_color%}%{$fg[yellow]%}†%{$reset_color%}%{$fg_bold[blue]%}%m%{$reset_color%}:%{${fg_bold[green]}%}%~%{$reset_color%}
%{$fg_bold[yellow]%}▲ ▲ %{$reset_color%}%{$fg[magenta]%}%w ⌛ %@%{$reset_color%} $(git_prompt_info)
%{${fg[$CARETCOLOR]}%}%# %{${reset_color}%}'

#RPS1='${return_code} %D - %*'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}LVL-%{$reset_color%}%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}[%{$reset_color%}%{$fg[white]%}B-†%{$fg[blue]%}][%{$fg[white]%}A-🛡%{$fg[blue]%}]%{$fg_bold[red]%} -LIFE- ♥ ♡ ♡ ♡ ♡ ♡ ♡ ♡ ♡ ♡"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ?"

ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}[%{$reset_color%}%{$fg[white]%}B-✝%{$fg[blue]%}][%{$fg[white]%}A-🛡%{$fg[blue]%}]%{$fg_bold[red]%} -LIFE- ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥"


# ᗜ ¤=[]:::::>
