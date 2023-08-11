function changeCodeContext() {
  cd $1 &&
    code $1 -r
}

alias codezsh='changeCodeContext ~/.oh-my-zsh/custom/'