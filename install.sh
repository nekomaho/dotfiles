DOTFILES_PATH=~/dotfiles
DOTVIM_PAHT=~/.vim

# install .vimrc
mkdir -p $DOTFILES_PATH

if [ -e ~/.vimrc ]; then
  mv ~/.vimrc $DOTFILES_PATH/.vimrc_back
fi

git clone https://github.com/Shougo/dein.vim $DOTFILES_PATH/dein

cp .vimrc $DOTFILES_PATH/.vimrc

ln -s $DOTFILES_PATH/.vimrc ~/.vimrc
