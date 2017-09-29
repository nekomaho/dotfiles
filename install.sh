DOTFILES_PATH=~/.dotfiles
QFIXHOWM_PATH=~/.qfixhowm
ZSH_INSTALL_PATH=/usr/bin/local/zsh
SRC=~/src
APP=~/app
VIM_GIT_URL=https://github.com/vim/vim.git
DEIN_GIT_URL=https://github.com/Shougo/dein.vim
VIM_CLONE_PATH=$SRC/vim

app_install()
{
  app_name=$1
  if brew info $app_name | grep "Not installed" > /dev/null 2>&1; then
    echo "-- install $app_name --"
    brew install $app_name
    echo "-- $app_name installed --"
    return 1
  fi
  return  0
}

app_make()
{
  make && make test && make install
  if [ $? -ne 0 ]; then
    echo "make failure"
    exit 1
  fi
}

# check homebrew
if ! (type brew) > /dev/null 2>&1; then
  echo "require homebrew"
  exit 1
fi

# create dir
mkdir -p $DOTFILES_PATH
mkdir -p $SRC
mkdir -p $APP

# install zsh
app_install zsh
zsh_result=$?
app_install zsh-completions
zsh_comp_result=$?

if [ $zsh_result -eq 1 ] && [ $zsh_comp_result -eq 1 ]; then
  if ! (grep "$ZSH_INSTALL_PATH" /etc/shell) > /dev/null 2>&1; then
    read -sp "Password: " password
    tty -s && echo
    echo "$password" | sudo -S sh -c "echo '$ZSH_INSTALL_PATH' >> /etc/shell"
  fi
  chsh -s $ZSH_INSTALL_PATH
fi

## install .zshrc
echo "-- install .zshrc..."
if [ -e ~/.zshrc ]; then
  mv ~/.zshrc $DOTFILES_PATH/.zshrc_back
fi

cp .zshrc $DOTFILES_PATH/.zshrc

ln -s $DOTFILES_PATH/.zshrc ~/.zshrc
echo "-- .zshrc installed"

# install vim
current_dir=$(cd $(dirname $0); pwd)
if [ -d $SRC/vim/ ]; then
  cd $VIM_CLONE_PATH
  git pull
  make clean
else
  app_install lua
  git clone $VIM_GIT_URL $VIM_CLONE_PATH
  cd $VIM_CLONE_PATH
fi

config_str=(prefix=$HOME/app --enable-luainterp=yes --enable-rubyinterp=yes --enable-multibyte --enable-terminal --enable-darwin --enable-python3interp=dynamic --enable-pythoninterp=dynamic --with-lua-prefix=/usr/local)
./configure "${config_str[@]}"
app_make

cd $current_dir

# install .vimrc
echo "-- install .vimrc..."
if [ -e ~/.vimrc ]; then
  mv ~/.vimrc $DOTFILES_PATH/.vimrc_back
fi

git clone $DEIN_GIT_URL $DOTFILES_PATH/dein

cp .vimrc $DOTFILES_PATH/.vimrc

ln -s $DOTFILES_PATH/.vimrc ~/.vimrc

mkdir -p $QFIXHOWM_PATH

echo "-- .vimrc installed"

