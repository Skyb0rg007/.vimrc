" Starts the VimPlug block
call plug#begin('~/.vim/plugged')

" Plug 'tomasr/molokai'            " Molokai Coloscheme
" Plug 'calincru/peaksea.vim'      " Peaksea theme

" Plug 'rhysd/clever-f.vim'        " Clever F
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
Plug 'bling/vim-bufferline'      " Buffer control 2
Plug 'godlygeek/tabular', {'on':['Tab']} " Formatting
Plug 'tpope/vim-fireplace',                        {'for':'clojure'} " Clojure quasi-REPL
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for':'clojure'} " Sexy people = sexy mappings
Plug 'guns/vim-sexp',                              {'for':'clojure'} " Lisp parenthesis help
Plug 'guns/vim-clojure-static',                    {'for':'clojure'} " More Clojure support
Plug 'guns/vim-clojure-highlight',                 {'for':'clojure'} " More Clojure highlighting
Plug 'dgrnbrg/vim-redl',                           {'for':'clojure'} " Clojure REPL session
Plug 'luochen1990/rainbow',                        {'for':'clojure'} " Rainbow Parenthesis
Plug 'MicahElliott/vim-clojure-fontlocks',         {'for':'clojure'} " Clojure conceal

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
set wildmenu
set wildmode=full  " Tab complete in Command Bar
filetype plugin on " Custom plugins for each filetype
filetype indent on " Custom indentation for each filetype
let mapleader      = ","  " <Leader> is , (the comma)
let g:mapleader    = ","  " Same as above
let maplocalleader = ",q" " Because Sexp is weird
set nowrap                " Long lines don't wrap

" Allow use of , and ; for f and t
nnoremap ,, ,

" Insert one letter
nnoremap <Space> i_<ESC>r

" :W saves when root is needed
cmap W w !sudo tee > /dev/null %

" Pressing enter clears search highlighting
nnoremap <CR> :noh<CR><CR> 

" Buffer management
set hidden   " Lets you hide modified buffers
nmap <Leader>T  :enew<CR>
nmap <Leader>l  :bnext<CR>
nmap <Leader>k  :bprevious<CR>
nmap <Leader>bq :bp <BAR> bd #<CR>
nmap <Leader>bd :bd<CR>
nmap <Leader>bl :ls<CR>

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

" ALE settings
" Shows the linter the error comes from
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s'

" Sets color scheme:
syntax enable
set background=dark
" colorscheme peaksea
" colorscheme molokai
set termguicolors

" Lightline settings:
set noshowmode   " Hides insert bar because Lightline takes care of it
set laststatus=2 " Needed to ensure Lightline is shown
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \ 'left': [ ['mode', 'paste'],
      \ ['fugitive', 'readonly', 'filename', 'modified'],
      \ ['bufferline'] ],
      \ 'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \ 'bufferline': '%{bufferline#refresh_status()}%{g:bufferline_status_info.before}'.
      \ '%#TabLineSel#%{g:bufferline_status_info.current}'.
      \ '%#LightLineLeft_active_2#%{g:bufferline_status_info.after}',
      \ 'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \ 'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \ 'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \ 'readonly': '(&filetype!="help"&& &readonly)',
      \ 'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \ 'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

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
highlight ColorColumn ctermbg=DarkCyan
call matchadd('ColorColumn', '\%81v', 100)

" NERDCommenter settings:
let g:NERDSpaceDelims = 1 " Add one space after comment 

" Clojure Settings
let g:redl_use_vsplit = 1 " split REPL vertically
let g:rainbow_active  = 1 " Rainbow Paren active
