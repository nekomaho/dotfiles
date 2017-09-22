"set config
set title
set number
set shiftwidth=2 " auto indent width
set autoread     " auto reload
set cursorline   " highlight current line
set cursorcolumn " highlight current column
set showmatch    " the cursor will briefly jump to the matching brace when you insert onef
set matchtime=1  " showmatch cursor jump time [100ms]
set display=lastline "display long line
set hlsearch "highlight search keyword
set clipboard+=unnamed "use os clipboard
set encoding=utf-8 

"End set config
"Key map config
nnoremap Y y$ 
nnoremap + <C-a>    " increment number
nnoremap - <C-x>    " decrement number
nnoremap sw <C-w>w  " move next window

" semicolon key map to colon
map ; :
noremap ;; ;
imap ; :
inoremap ;; ;

inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>  " when Japanese input

"End map config
"Display invisibles
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

"Display Zenkaku Space
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdegraphicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdegraphicSpace /　/
augroup  END

"End Display invisibles
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let vimbundle_path='~/dotfiles'
let dein_vim_path='~/dotfiles/dein'


" Required:
set runtimepath+=~/dotfiles/dein

" Required:
if dein#load_state(vimbundle_path)
  call dein#begin(vimbundle_path)

  " Let dein manage dein
  " Required:
  call dein#add(dein_vim_path)

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('scrooloose/nerdtree')
  call dein#add('w0ng/vim-hybrid')
  call dein#add('tpope/vim-fugitive')  "git wrapper
  call dein#add('nathanaelkane/vim-indent-guides') "display indent levels
  call dein#add('godlygeek/tabular') "formatting text for markdown
  call dein#add('plasticboy/vim-markdown') "markdown extensions
  call dein#add('kannokanno/previm') "preview markdown
  call dein#add('tpope/vim-endwise') "adding end after if,do,def and several other keywords.
  call dein#add('cohama/lexima.vim') "auto close parentheses
  call dein#add('tpope/vim-rails')
  call dein#add('tmhedberg/matchit') "extension % command
  call dein#add('tpope/vim-surround') "extension text object

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable
colorscheme hybrid

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"NERDTree settings
autocmd VimEnter * execute 'NERDTree'

" vim-markdown settings
let g:vim_markdown_new_list_item_indent = 2

" markdown preview settings
let g:previm_open_cmd = 'open -a Google\ Chrome'
nmap <C-S-p> :PrevimOpen<CR>

" vim-indent-guides settings
set background=dark
let g:indent_guides_enable_on_vim_startup=1 " always enabled
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=lightgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightgrey

"End dein Scripts-------------------------


