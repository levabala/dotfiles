createLink() {
  RELATIVE_PATH=$(grealpath --relative-to=$HOME/.dotfiles $0)
  echo $RELATIVE_PATH
  mkdir -p $HOME/$(dirname $RELATIVE_PATH)
  mkdir -p $HOME/.dotfiles_backup/$(dirname $RELATIVE_PATH)
  mv $HOME/$RELATIVE_PATH $HOME/.dotfiles_backup/$RELATIVE_PATH
  ln -s $0 $HOME/$RELATIVE_PATH
}
export -f createLink

find $HOME/.dotfiles -type f ! -path "$HOME/.dotfiles/.git/*" ! -path "$HOME/.dotfiles/**/*.backup" -exec sh -c 'createLink "$0"' {} \;
