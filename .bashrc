export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Run twolfson/sexy-bash-prompt
. ~/.bash_prompt

# alias be="bundle exec"

export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash" #this is from bash profile, may need it later

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"
#alias config='/usr/bin/git --git-dir=/Users/naderarbabian/.cfg/ --work-tree=/Users/naderarbabian'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# added by travis gem
[ -f /Users/naderarbabian/.travis/travis.sh ] && source /Users/naderarbabian/.travis/travis.sh
