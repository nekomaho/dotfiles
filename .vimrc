"set ionfig
set title
set number
set shiftwidth=2 "自動インデントでずれる幅
set autoread     " 編集中のファイルが変更されたら自動で読み直す
set cursorline   " 現在の行を強調表示
set cursorcolumn " 現在の行を強調表示（縦）
set showmatch    " 括弧入力時の対応する括弧を表示
set matchtime=1  " showmatch実行時の秒数[100ms]
set display=lastline "長い行を最後まで表示

"End set config
"Key map config
nnoremap Y y$ 
nnoremap + <C-a>    " インクリメント
nnoremap - <C-x>    " デクリメント
nnoremap sw <C-w>w  " 次のウィンドウに移動

"End map config
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let vimbundle_path='~/.vim/bundles'
let dein_vim_path='~/.vim/bundles/repos/github.com/Shougo/dein.vim'


" Required:
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(vimbundle_path)
  call dein#begin(vimbundle_path)

  " Let dein manage dein
  " Required:
  call dein#add(dein_vim_path)

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
  call dein#add('scrooloose/nerdtree')
  call dein#add('w0ng/vim-hybrid')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable
colorscheme hybrid
autocmd VimEnter * execute 'NERDTree'

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


"End dein Scripts-------------------------


