" Starts the VimPlug block
call plug#begin('~/.vim/plugged')

" Plug 'xolox/vim-easytags'
" Plug 'xolox/vim-misc'
Plug 'kana/vim-arpeggio'         " Mappings for pressing 2 keys at once
Plug 'ktonga/vim-follow-my-lead' " <Leader>fml shows all mappings
Plug 'majutsushi/tagbar'         " Handles showing class instances
Plug 'mtth/scratch.vim'          " Scratch window
Plug 'KeitaNakamura/neodark.vim' " Neodark
Plug 'morhetz/gruvbox'           " GruvBox color theme
Plug 'kien/ctrlp.vim'            " Fuzzy finder
Plug 'maximbaz/lightline-ale'    " Lightline + ALE
Plug 'scrooloose/nerdtree'       " NERDTree
Plug 'itchyny/lightline.vim'     " Status bar
Plug 'w0rp/ale'                  " Continuous linting
Plug 'tpope/vim-unimpaired'      " Useful key mappings
Plug 'junegunn/goyo.vim'         " Distraction-free writing
Plug 'SirVer/ultisnips'          " Snippet engine
Plug 'honza/vim-snippets'        " The snippets themselves
Plug 'sheerun/vim-polyglot'      " Language packs
Plug 'tpope/vim-surround'        " Surrounding quotes
Plug 'tpope/vim-repeat'          " Helps with Surround.vim
Plug 'airblade/vim-gitgutter'    " Shows git diff in real time
Plug 'easymotion/vim-easymotion' " EasyMotion
Plug 'scrooloose/nerdcommenter'  " NERDCommenter
Plug 'tpope/vim-fugitive'        " Git integration
Plug 'zenbro/mirror.vim'         " Remote control
Plug 'bling/vim-bufferline'      " Buffer control
Plug 'godlygeek/tabular', {'on':['Tab']} " Formatting

" Clojure stuff
Plug 'tpope/vim-fireplace',                        
            \ {'for':'clojure'} " Clojure quasi-REPL
Plug 'tpope/vim-sexp-mappings-for-regular-people', 
            \ {'for':'clojure'} " Sexy people = sexy mappings
Plug 'guns/vim-sexp',                              
            \ {'for':'clojure'} " Lisp parenthesis help
Plug 'guns/vim-clojure-static',                    
            \ {'for':'clojure'} " More Clojure support
Plug 'guns/vim-clojure-highlight',                 
            \ {'for':'clojure'} " More Clojure highlighting
Plug 'dgrnbrg/vim-redl',                           
            \ {'for':'clojure'} " Clojure REPL session
Plug 'luochen1990/rainbow',                        
            \ {'for':'clojure'} " Rainbow Parenthesis
" Plug 'MicahElliott/vim-clojure-fontlocks',         
            " \ {'for':'clojure'} " Clojure conceal

call plug#end()

nmap <Right> :vertical resize +1<CR>
nmap <Left> :vertical resize -1<CR>
nmap <Up> :resize +1<CR>
nmap <Down> :resize -1<CR>

inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-x> "+d

set nocompatible   " Disables backward compatibility with vi
set mouse=a        " Allows use of the mouse
set infercase      " Infer case while searching
set tabstop=4      " Tab is 4 spaces
set shiftwidth=4   " '>' is also 4 spaces
set expandtab      " Tab is replaced with 4 spaces
set ignorecase
set smartcase
set wildmenu
set wildmode=full  " Tab complete in Command Bar
filetype plugin on " Custom plugins for each filetype
filetype indent on " Custom indentation for each filetype
let mapleader      = ","  " <Leader> is , (the comma)
let g:mapleader    = ","  " Same as above
let maplocalleader = ",q" " Because Sexp is weird
set nowrap                " Long lines don't wrap
set textwidth=0 wrapmargin=0 " Don't auto-insert newlines
set ttimeoutlen=100  " Why is there a delay between insert and normal?
                     " Who wants that???

" Sets jumpstack when a number is used with a movement
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Allow use of , and ; for f and t
nnoremap ,, ,
let g:fml_all_sources=1

" Insert one letter
nnoremap <Space> i_<ESC>r

" ,ww saves when root is needed
nnoremap <Leader>ww :w !sudo tee > /dev/null %

" Pressing \ clears search highlighting
nnoremap \ :noh<CR>

" Buffer management
set hidden   " Lets you hide modified buffers
nmap <Leader>t  :enew<CR>
nmap <Leader>l  :bnext<CR>
nmap <Leader>k  :bprevious<CR>
nmap <Leader>bq :bp <BAR> bd #<CR>
nmap <Leader>bd :bd<CR>
nmap <Leader>bl :ls<CR>

" Tab management
nmap <Leader>T  :tabnew<CR>
nmap <Leader>L  :tabnext<CR>
nmap <Leader>K  :tabprevious<CR>
nnoremap <C-W>t <C-W>T

" Manage window sizes with arrow keys in normal mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Disable q: pulling up command-line window
" Every time I want to just :q ...
noremap q: <nop>

" F2 toggles fullscreen command-line window
nnoremap <F2> q:<C-w>_
augroup ECW_au
    au!
    au CmdwinEnter * nmap <F2> :q<CR>
    au CmdwinLeave * nmap <F2> q:<C-w>_
augroup END

" Change word under cursor with . repeat (*=forwards, #=backwards)
nnoremap c* *Ncgn
nnoremap c# #Ncgn

" C-t in visual mode aligns
vnoremap <C-t> :Tab /

" Calling macro over visual selection does matching lines
" and skips non-matches
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

" NERDTree settings
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-q> <C-t>

" ALE settings
" Shows the linter the error comes from
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s'

" Lightline settings:
set noshowmode    " Hides insert bar because Lightline takes care of it
set laststatus=2  " Needed to ensure Lightline is shown
set showtabline=1 " Show tab line as soon as there are at least 2
let g:bufferline_echo = 1
let g:lightline = {
      \ 'colorscheme': 'neodark',
      \ 'active': {
      \     'left':  [  ['mode', 'paste'],
      \                 ['fugitive', 'readonly', 'filename', 'modified'] ],
      \     'right': [  ['lineinfo'], ['percent'], 
      \                 ['linter_errors', 'linter_warnings', 'linter_ok'] ]
      \ },
      \ 'component': {
      \     'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \     'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \     'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_expand': {
      \     'linter_warnings': 'lightline#ale#warnings',
      \     'linter_errors': 'lightline#ale#errors',
      \     'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'green',
      \ },
      \ 'component_visible_condition': {
      \     'readonly': '(&filetype!="help"&& &readonly)',
      \     'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \     'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }
let g:lightline.tabline = {
    \ 'left': [ ['tabs'] ],
    \ 'right':[ ['close'] ] }
let g:lightline#ale#indicator_warnings = ""
let g:lightline#ale#indicator_errors = ""
let g:lightline#ale#indicator_ok = ""

" ALE settings
let g:ale_linters = {
    \ 'cpp': ['clang','clangtidy','clang-format','cppcheck','cpplint','gcc']
    \ } " No clangcheck because it doesn't include c++11 standard
 
" UtiliSnips settings:
let g:UltiSnipsExpandGrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" EasyMotion settings:
let g:EasyMotion_do_mapping=0 "Disable Defaults
let g:EasyMotion_smartcase=1
map <C-l> <Plug>(easymotion-lineforward)
map <C-j> <Plug>(easymotion-j)
map <C-k> <Plug>(easymotion-k)
map <C-h> <Plug>(easymotion-linebackward)

" Highlight the 80th character
set cc=80

" NERDCommenter settings:
let g:NERDSpaceDelims = 1 " Add one space after comment 

" Use man 3 as the K lookup if file is C
autocmd BufNewFile,BufRead *.c runtime ftplugin/man.vim
autocmd BufNewFile,BufRead *.c set keywordprg=:Man\ 3
" man 1 if bash
autocmd BufNewFile,BufRead *.sh runtime ftplugin/man.vim
autocmd BufNewFile,BufRead *.sh set keywordprg=:Man\ 1

" Clojure Settings
let g:redl_use_vsplit = 1 " split REPL vertically
let g:rainbow_active  = 1 " Rainbow Paren active

" Sets color scheme:
syntax enable
set termguicolors
let g:neodark#background = '#202020'
set background=dark
colorscheme neodark

" Sets the cursor to be a line in insert mode and block in normal mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
" autocmd VimEnter * noh
augroup END

" This is for tagbar
nnoremap <F8> :TagbarToggle<CR>

" jk at the same time exits insert mode
call arpeggio#map('i', '', 0, 'jk', '<Esc>')
imap jj <ESC>
