DOTFILES_PATH=~/dotfiles
DOTVIM_PAHT=~/.vim
QFIXHOWM_PATH=~/.qfixhowm
ZSH_INSTALL_PATH=/usr/bin/local/zsh

# check homebrew
if ! (type brew) > /dev/null 2>&1; then
  echo "require homebrew"
  exit 1
fi

# create dir
mkdir -p $DOTFILES_PATH

# install zsh
if brew info zsh | grep "Not installed" > /dev/null 2>&1; then
  echo "-- install zsh and zsh-completions..."
  brew install zsh && brew install zsh-completions

  if ! (grep "$ZSH_INSTALL_PATH" /etc/shell) > /dev/null 2>&1; then
    read -sp "Password: " password
    tty -s && echo
    echo "$password" | sudo -S sh -c "echo '$ZSH_INSTALL_PATH' >> /etc/shell"
  fi
  chsh -s $ZSH_INSTALL_PATH
  echo "-- zsh and zsh-completions installed"
fi

## install .zshrc
echo "-- install .zshrc..."
if [ -e ~/.zshrc ]; then
  mv ~/.zshrc $DOTFILES_PATH/.zshrc_back
fi

cp .zshrc $DOTFILES_PATH/.zshrc

ln -s $DOTFILES_PATH/.zshrc ~/.zshrc
echo "-- .zshrc installed"


# install .vimrc
echo "-- install .vimrc..."
if [ -e ~/.vimrc ]; then
  mv ~/.vimrc $DOTFILES_PATH/.vimrc_back
fi

git clone https://github.com/Shougo/dein.vim $DOTFILES_PATH/dein

cp .vimrc $DOTFILES_PATH/.vimrc

ln -s $DOTFILES_PATH/.vimrc ~/.vimrc

mkdir -p $QFIXHOWM_PATH

echo "-- .vimrc installed"
