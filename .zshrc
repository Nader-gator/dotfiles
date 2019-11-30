source ~/.profile
export LANG=en_US.UTF-8
  export EDITOR='nvim'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
mcr(){
  gcc $1 && ./a.out
}
count_lines(){
cat $(find . -name $1) | grep -E -v '^\s*$|^\s*#' | wc -l
}
gip(){
git add .;git commit -m "$1";git push
}
se(){
source ~/Code_stuff/Enviroments/$1/bin/activate
}
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
# added by travis gem
[ -f /Users/naderarbabian/.travis/travis.sh ] && source /Users/naderarbabian/.travis/travis.sh
plugins=(
  git
  iterm2
  macports
  man
  osx
  python
  composer
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
