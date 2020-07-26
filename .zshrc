source ~/.profile
export LANG=en_US.UTF-8
export EDITOR='nvim'
mcr(){
  gcc -g -o a.out "$1" && ./a.out $2
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
install_lib(){
    ve && \
    cd libs/vero_grpc_lib && \
    ./compile.sh && \
    ve && \
    cd libs/ && \
    ./reinstall-library.sh
}

install_lib_re(){
    ve && \
    ggel && \
    ve && \
    cd libs/ && \
    ./reinstall-library.sh && \
    ve && \
    docker-compose restart && \
    sc && \
    docker-compose restart && \


}
copy_lib(){
    cd ~/Code_stuff/vero/libs/vero_grpc_lib
    python setup.py sdist
    rm -r *.egg-info
    cd ~/Code_stuff/vero/libs/vero_shared_lib
    python setup.py sdist
    rm -r *.egg-info
    cd ~/Code_stuff/legacy/dist/
    rm -f *
    cp ~/Code_stuff/vero/libs/vero_grpc_lib/dist/*.gz .
    cp ~/Code_stuff/vero/libs/vero_shared_lib/dist/*.gz .
    # echo "Success local regen"
    # if [[ "$1" = "1" ]] || [[ -z "$1" ]]
    # then
    #     sc
    #     docker-compose stop
    #     reinstalll_package vero_django app
    #     reinstalll_package vero_django_grpc grpc
    #     reinstalll_package vero_rqworker rqworker
    #     docker-compose restart
    # fi
    # if [[ "$1" = "2" ]] || [[ -z "$1" ]]
    # then
    #     ve
    #     docker-compose stop
    #     exec_reinstall stonehenge-poll stonehenge-poll
    #     exec_reinstall stonehenge-grpc-server stonehenge_grpc
    #     docker-compose restart
    # fi
}
reinstalll_package(){
    docker-compose up -d $2
    docker cp dist $1:/usr/app
    docker exec $1 sh -c "pip install /usr/app/dist/*"
}
exec_reinstall(){
    docker-compose up -d $2
    docker exec $1 sh -c "cd /vero/libs/ && ./reinstall-library.sh"
}

up(){
    docker-compose -f docker-compose.override.yml up -d "$@"
}
stop(){
    docker-compose -f docker-compose.override.yml stop "$@"
}
restart(){
    docker-compose -f docker-compose.override.yml restart "$@"
}
down(){
    docker-compose -f docker-compose.override.yml down
}
dps(){
    docker-compose -f docker-compose.override.yml ps
}
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] \
    && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
# added by travis gem
[ -f /Users/naderarbabian/.travis/travis.sh ] \
    && source /Users/naderarbabian/.travis/travis.sh
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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
unalias rm
alias lzd='lazydocker'
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval "$(direnv hook zsh)"
