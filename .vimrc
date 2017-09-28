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
" increment number
nnoremap + <C-a>
" decrement number
nnoremap - <C-x>
" move next window
nnoremap sw <C-w>w

" semicolon key map to colon
map ; :
noremap ;; ;
imap ; :
inoremap ;; ;

inoremap <silent> jj <ESC>
" when Japanese input
inoremap <silent> っｊ <ESC>

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
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete')
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
  call dein#add('itchyny/calendar.vim') "view calendar plugins
  call dein#add('slim-template/vim-slim') "slim syntax hightlight

  call dein#add('fuenor/qfixhowm') " hownm tool of vim

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

" calendar settings
let g:calendar_google_calendar = 1

" slim plugin settings
autocmd BufRead,BufNewFile *.slim setfiletype slim

" QFixHowm settings
let hown_dir = '~/.qfixhowm'
let hown_fileencoding = 'utf-8'
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'
let hown_fileformat = 'unix'
let QFixHowm_UserFileType = 'markdown'
let QFixHowm_UserFileExt= 'md'
let QFixHowm_Title = '#'

" ---snippet settings start---
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" " For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif 

"set snippet file dir
let g:neosnippet#snippets_directory = '~/.vim/bundle/neosnippet-snippets/neosnippets/,~/.dotfiles/snippets'
" ---snippet settings end---

" ---neocomplete settings start---
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
       \ 'default' : '',
       \ 'vimshell' : $HOME.'/.vimshell_hist',
       \ 'scheme' : $HOME.'/.gosh_completions'
       \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
   return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
" For no inserting <CR> key.
"   "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#auto_completion_start_length = 1
call neocomplete#custom#source('buffer', 'disabled_filetypes', {'_' : 1})

" ---neocomplete settings end---
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

