#!usr/bin/env bash
"vimrc configuration file
set noruler
set confirm
<<<<<<< HEAD
set tabstop=4       " Number of spaces that a <Tab> in the file counts for
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set expandtab       " Use spaces instead of tabs
=======
set tabstop=8       " Number of spaces that a <Tab> in the file counts for
autocmd Filetype css setlocal tabstop=4
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
"set expandtab       " Use spaces instead of tabs
set noexpandtab
set autoindent
set smartindent
set expandtab
set hls is
set ic
set laststatus=2
set cmdheight=1
set encoding=UTF-8
set noshowmode
syntax on
set autoread
set spelllang=en_us
set spell
set number
set relativenumber
set cursorline
"set colorcolumn=120
set wildmenu
"set foldmethod=indent
"set foldcolumn=1
"highlight Folded guifg=PeachPuff4
"highlight FoldColumn guibg=darkgrey guifg=white

"set statusline=================%m%r%h \ %f\ %=%-14.(%l,%c%V%)\ %P
<<<<<<< HEAD
colorscheme pablo 
colorscheme darkblue 
hi Normal guibg=NONE ctermbg=NONE
set background=dark
"-----------------------"
"       PLUGIN          "
"-----------------------"

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf'
    Plug 'skywind3000/vim-quickui'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'mbbill/undotree'
    Plug 'godlygeek/tabular'
    "Plug 'preservim/vim-markdown'
    "Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}"
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/goyo.vim'
    "Plug 'airblade/vim-gitgutter'"
    "Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'
    "Plug 'junegunn/fzf'
    "Plug 'skywind3000/vim-quickui'
    "Plug 'skywind3000/asyncrun.vim'
    "Plug 'mbbill/undotree'
    "Plug 'godlygeek/tabular'
    "Plug 'preservim/vim-markdown'
    "Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}"
    "Plug 'junegunn/limelight.vim'
    Plug 'dense-analysis/ale'
    Plug 'jiangmiao/auto-pairs'
    "Plug 'junegunn/goyo.vim'
    "Plug 'airblade/vim-gitgutter'
    call plug#end()





"======================"
"      Markdown
"======================"
let g:vim_markdown_folding_disabled = 1


"----------------------"
"      UNDOTREE        "
"----------------------"
nnoremap <F3> :UndotreeToggle<CR>

"-----------------------"
"      NERDTREE         "
"-----------------------"

" Start NERDTree and leave the cursor in it.
"autocmd VimEnter * NERDTree

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

let g:NERDTreeFileLines = 1

"----------------------"
"       MAPPING        "
"----------------------"
<<<<<<< HEAD
":let mapleader = "\"
=======
":let g:mapleader="\"
>>>>>>> 56fc345 (July Update)

"nnoremap <C-t> :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>                        
nnoremap <leader>] :NERDTreeToggle<CR>              " \+] mapped to Toggle NERDTree
"nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <C-r> :source ~/.vimrc<CR>                 "Reload vim configuration


"----------------------"
"        QUICKUI       "
"----------------------"
" clear all the menus
<<<<<<< HEAD
call quickui#menu#reset()

" install a 'File' menu, use [text, command] to represent an item.
call quickui#menu#install('&File', [
=======
"call quickui#menu#reset()

" install a 'File' menu, use [text, command] to represent an item.
"call quickui#menu#install('&File', [
>>>>>>> 56fc345 (July Update)
            \ [ "&New File\tCtrl+n", 'echo 0' ],
            \ [ "&Open File\t(F3)", 'echo 1' ],
            \ [ "&Close", 'echo 2' ],
            \ [ "--", '' ],
            \ [ "&Save\tCtrl+s", 'echo 3'],
            \ [ "Save &As", 'echo 4' ],
            \ [ "Save All", 'echo 5' ],
            \ [ "--", '' ],
            \ [ "E&xit\tAlt+x", 'echo 6' ],
            \ ])

" items containing tips, tips will display in the cmdline
<<<<<<< HEAD
call quickui#menu#install('&Edit', [
=======
"call quickui#menu#install('&Edit', [
>>>>>>> 56fc345 (July Update)
            \ [ '&Copy', 'echo 1', 'help 1' ],
            \ [ '&Paste', 'echo 2', 'help 2' ],
            \ [ '&Find', 'echo 3', 'help 3' ],
            \ ])

<<<<<<< HEAD
call quickui#menu#install("&Build", [
=======
"call quickui#menu#install("&Build", [
>>>>>>> 56fc345 (July Update)
            \ [ '&Compile', 'echo 1' ],
            \ [ '&Run', 'echo 2' ],
            \ ])  

" script inside %{...} will be evaluated and expanded in the string
<<<<<<< HEAD
call quickui#menu#install("&Option", [
=======
"call quickui#menu#install("&Option", [
>>>>>>> 56fc345 (July Update)
			\ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
			\ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
			\ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
			\ ])

" register HELP menu with weight 10000
<<<<<<< HEAD
call quickui#menu#install('H&elp', [
=======
"call quickui#menu#install('H&elp', [
>>>>>>> 56fc345 (July Update)
			\ ["&Cheatsheet", 'help index', ''],
			\ ['T&ips', 'help tips', ''],
			\ ['--',''],
			\ ["&Tutorial", 'help tutor', ''],
			\ ['&Quick Reference', 'help quickref', ''],
			\ ['&Summary', 'help summary', ''],
			\ ], 10000)

" enable to display tips in the cmdline
<<<<<<< HEAD
let g:quickui_show_tip = 1

" Border Style
let g:quickui_border_style = 3

" Color Scheme 
let g:quickui_color_scheme = 'gruvbox'

" hit Ctrl-space to open menu
noremap <F1> :call quickui#menu#open()<cr>

hi! QuickBG ctermfg=0 ctermbg=7 guifg=black guibg=gray
hi! QuickSel cterm=bold ctermfg=0 ctermbg=2 gui=bold guibg=brown guifg=gray
hi! QuickKey term=bold ctermfg=9 gui=bold guifg=#f92772
hi! QuickOff ctermfg=59 guifg=#75715e
hi! QuickHelp ctermfg=247 guifg=#959173
=======
"let g:quickui_show_tip = 1

" Border Style
"let g:quickui_border_style = 3

" Color Scheme 
"let g:quickui_color_scheme = 'gruvbox'

" hit Ctrl-space to open menu
"noremap <F1> :call quickui#menu#open()<cr>

"hi! QuickBG ctermfg=0 ctermbg=7 guifg=black guibg=gray
"hi! QuickSel cterm=bold ctermfg=0 ctermbg=2 gui=bold guibg=brown guifg=gray
"hi! QuickKey term=bold ctermfg=9 gui=bold guifg=#f92772
"hi! QuickOff ctermfg=59 guifg=#75715e
"hi! QuickHelp ctermfg=247 guifg=#959173
>>>>>>> 56fc345 (July Update)


"----------------------"
"      ASYNCRUN        "
"----------------------"
" <F9> to Compile the current File
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" <F5> to Run the current File
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 

" automatically open quickfix window when AsyncRun command is executed
" set the quickfix window 10 lines height.
let g:asyncrun_open = 10

" ring the bell to notify you job finished
let g:asyncrun_bell = 1

" F10 to toggle quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>



" -------------------------
" junegunn/limelight.vim
" -------------------------
let g:limelight_conceal_ctermfg=244

" ------------------------------
" iamcco/markdown-preview.nvim
" ------------------------------
let g:mkdp_auto_close=0
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='./github-markdown.css'

"----------------------------
"          AIRLINE
"----------------------------
":let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
