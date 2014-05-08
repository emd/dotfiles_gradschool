" Below, ``<C>`` and ``<c>`` stand for ``CTRL``

"============================================================================
" Package Management via Vundle
"============================================================================


" mkdir -p ~/.vim/bundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set nocompatible
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" let Vundle manage Vundle
Bundle 'gmarik/vundle'


" wombat256 color scheme
Bundle 'vim-scripts/wombat256.vim'


" Powerline
Bundle 'Lokaltog/vim-powerline'
set nocompatible
set laststatus=2
"let g:Powerline_symbols = 'fancy'


" Syntastic
Bundle 'scrooloose/syntastic'
" Also, need to ensure that the required syntax checker
" (e.g. flake8) is installed
" pip install flake8
let g:syntastic_always_populate_loc_list = 1


" Supertab
Bundle  'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"


" ctrlp
Bundle 'kien/ctrlp.vim'
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" Efficient python folding
Bundle 'Efficient-python-folding'


" jedi-vim
Bundle 'davidhalter/jedi-vim'
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
let g:jedi#auto_close_doc = 1
let g:jedi#rename_command = ""
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>


" " Better navigating through omnicomplete option list
" " See
" http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
if pumvisible()
if a:action == 'j'
return "\<C-N>"
elseif a:action == 'k'
return "\<C-P>"
endif
endif
return a:action
endfunction
inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" vim-latex
Bundle 'jcf/vim-latex'

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor = 'latex'

"let g:Tex_CompileRule_pdf='pdflatex -synctex=1 -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'open -a Preview'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf'

" m is the meta key; useful for e.g. adding items to a list in aTeX
" Using OSX default terminal, ensure that "Use option as meta key"
" is selected in the keyboard section of the Terminal Preferences
" Get the RHS by typing Ctrl-V Alt-i
set <m-i>=i

" Remap vim-latex's jump to next placeholder function as
" the default (<c-j>) is being used for movement between windows
imap <c-n> <Plug>IMAP_JumpForward
nmap <c-n> <Plug>IMAP_JumpForward


filetype plugin indent on " required!


"============================================================================
" Additional Vim settings
"============================================================================


" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
set clipboard=unnamed


" Mouse and backspace
set mouse=a " on OSX press ALT and click
set bs=2 " make backspace behave like normal again


" Rebind <Leader> key
" It is easier to reach than the default leader key (i.e. backslash) and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Bind nohl
" Removes highlight of your last search
noremap <C-o> :nohl<CR>
vnoremap <C-o> <C-C>:nohl<CR>
inoremap <C-o> <C-O>:nohl<CR>


" Quick save command
noremap <Leader>s :update<CR>


" Quick run command
" TODO: Open a buffer window to display executable results
noremap <Leader>r :update<CR>:!python %<CR><CR>


" Quick quit command
noremap <Leader>e :quit<CR> " Quit current window
noremap <Leader>E :qa!<CR> " Quit all windows


" Easy movement between windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h


" easier moving between tabs
map <Leader>t <esc>:tabnew<CR>
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
set t_Co=256
color wombat256mod


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


" Showing line numbers and length
set number " show line numbers
set ruler " show cursor line number (and %) and column number
set tw=79 " width of document (used by gd)
set nowrap " don't automatically wrap on load
set fo-=t " don't automatically wrap text when typing
if exists("&colorcolumn")
    set colorcolumn=80
endif
highlight ColorColumn ctermbg=233


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
