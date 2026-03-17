alias limsdb=PGHOST=/Users/gautham/src/lims/.cirun psql -U postgres -d neuralims_dev
export DIRENV_LOG_FORMAT=$'\033[22m\033[2mdirenv: %s\033[0m\033[22m'
eval "$(direnv hook zsh)"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# aliases
alias v=nvim
alias gs="git status"
alias amendp="git commit --amend --no-edit --no-verify && git push -f"
alias diffmaster="git diff master...HEAD"

# Custom prompt with date/pwd/branch
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
export PGHOST=/Users/gautham/src/lims/.cirun
export POSTGRES_USER=postgres

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/.local/bin:$PATH"
. "/Users/gautham/.deno/env"

# Fix Ctrl+arrow keys for word navigation
bindkey "^[[1;5C" forward-word      # Ctrl+Right
bindkey "^[[1;5D" backward-word     # Ctrl+Left
bindkey "^[[1;3C" forward-word      # Alt+Right (alternative)
bindkey "^[[1;3D" backward-word     # Alt+Left (alternative)
