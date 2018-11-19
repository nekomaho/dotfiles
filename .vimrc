"set config
set title
set number
set shiftwidth=2 " auto indent width
set autoread     " auto reload
set showmatch    " the cursor will briefly jump to the matching brace when you insert onef
set matchtime=1  " showmatch cursor jump time [100ms]
set display=lastline "display long line
set hlsearch "highlight search keyword
set clipboard+=unnamed "use os clipboard
set encoding=utf-8
set laststatus=2
set nocursorline
set nocursorcolumn
set norelativenumber
set splitright
set termwinscroll=100000
set incsearch
set redrawtime=5000

"End set config
"Key map config
nnoremap Y y$
" increment number
nnoremap n- <C-a>
" decrement number
nnoremap n+ <C-x>
" move next window
nnoremap sw <C-w>w
" move previous window
nnoremap sb <C-w>W
" enter terminal normal mode
tnoremap <silent> JJ <C-\><C-n>
tnoremap <silent> JJ <C-w>N
" move next window when terminal mode
tnoremap <C-s>w <C-w><C-w>
" move previous window when terminal mode
tnoremap <C-s>b <C-w>p

" semicolon key map to colon
map ; :
noremap ;; ;
imap ; :
inoremap ;; ;

inoremap <silent> jj <ESC>
" when Japanese input
inoremap <silent> っｊ <ESC>
" for ctags jump
nnoremap <C-]> g<C-]>

" gtags key binds
augroup gtagsKeySetting
  " <C-g> grep source code
  " <C-l> display function that which open file
  " <C-j> search definition
  " <C-k> search using function
  autocmd!
  autocmd BufNewFile,BufRead *.c nnoremap <C-g> :Gtags -g
  autocmd BufNewFile,BufRead *.c nnoremap <C-l> :Gtags -f %<CR>
  autocmd BufNewFile,BufRead *.c nnoremap <C-j> :Gtags <C-r><C-w><CR>
  autocmd BufNewFile,BufRead *.c nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
augroup END

"End map config
"Display invisibles
set list
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%

"Display Zenkaku Space
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdegraphicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdegraphicSpace /　/
augroup  END

"Display last space
augroup highlightLastSpace
  autocmd!
  autocmd Colorscheme * highlight LastSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match LastSpace /\s\+$/
augroup  END

"Line Number color settings
augroup highlightLine
  autocmd!
  autocmd Colorscheme * highlight LineNr ctermfg=246
augroup END

"Open Terminal with new tab
command! Nt call OpenNewTabWithTerminal()

function! OpenNewTabWithTerminal()
  tabnew
  term ++curwin
endfunction

"Open Terminal with new window
command! Ntw call OpenNewWindowWithTerminal()

function! OpenNewWindowWithTerminal()
  vnew
  term ++curwin
endfunction

"End Display invisibles
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let vimbundle_path='~/.dotfiles'
let dein_vim_path='~/.dotfiles/dein'


" Required:
set runtimepath+=~/.dotfiles/dein

" Required:
if dein#load_state(vimbundle_path)
  call dein#begin(vimbundle_path)

  " Let dein manage dein
  " Required:
  call dein#add(dein_vim_path)

  " Add or remove your plugins here:
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
  call dein#add('slim-template/vim-slim') "slim syntax highlight
  call dein#add('simeji/winresizer') "vim windows resize plugin
  call dein#add('vim-airline/vim-airline')  " Lean & mean status/tabline for vim that's light as air.
  call dein#add('vim-airline/vim-airline-themes')  " airline themes
  call dein#add('rking/ag.vim')  " for silver searcher plugin
  call dein#add('justinmk/vim-dirvish')  " Path navigator
  call dein#add('vim-scripts/gtags.vim')  " gtags plugin
  call dein#add('gregsexton/gitv') "git log viewr
  call dein#add('hotwatermorning/auto-git-diff') "git rebase viewer
  call dein#add('rhysd/committia.vim') "git commit viewr
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/unite.vim')
  call dein#add('airblade/vim-gitgutter') "git diff tool
  call dein#add('cohama/agit.vim') "git log viewr
  call dein#add('kchmck/vim-coffee-script') " coffee script syntax highlight
  call dein#add('pangloss/vim-javascript') "javascript indent
  call dein#add('maxmellon/vim-jsx-pretty') " jsx syntax highlight
  call dein#add('marijnh/tern_for_vim') " js auto complete
  call dein#add('othree/javascript-libraries-syntax.vim') "JS library syntax
  call dein#add('tyru/open-browser-github.vim') " for open github
  call dein#add('tyru/open-browser.vim') " for open github

  call dein#add('fuenor/qfixhowm') " hownm tool of vim
  call dein#add('soramugi/auto-ctags.vim')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

colorscheme hybrid

" vim-markdown settings
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_folding_disabled = 1

" markdown preview settings
let g:previm_open_cmd = 'open -a Google\ Chrome'
nmap <C-S-p> :PrevimOpen<CR>

" vim-indent-guides settings
set background=dark
let g:indent_guides_enable_on_vim_startup=1 " always enabled
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray

" calendar settings
let g:calendar_google_calendar = 1

" slim plugin settings
autocmd BufRead,BufNewFile *.slim setfiletype slim

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'molokai'

" QFixHowm settings
let hown_dir = '~/.qfixhowm'
let hown_fileencoding = 'utf-8'
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'
let hown_fileformat = 'unix'
let QFixHowm_UserFileType = 'markdown'
let QFixHowm_UserFileExt= 'md'
let QFixHowm_Title = '#'
" display QFixHowm list
nnoremap <silent> ssj :<C-U>call qfixmemo#Glob(g:qfixmemo_dir, "**/*", "open")<CR>

"End dein Scripts-------------------------

" ---start after enabled FileType plugin settings---
" tab settings
function! s:tab_settings() abort
  if &filetype =~ 'make'
    set noexpandtab
  else
    set expandtab
  endif
endfunction

augroup setting_tab_indents
  autocmd!
  autocmd BufRead,BufNewFile * call s:tab_settings()
augroup END
" ---end after enabled FileType plugin settings---

" coffee script settings
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
" --- end coffee script setting---

"unite.vim settings
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry

syntax sync minlines=256
