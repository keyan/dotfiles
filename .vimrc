set nocompatible "be iMproved
filetype off " necessary to make sure vundle does something
set modelines=0 "security hole involving modelines

filetype plugin indent on "required for vundle
syntax enable

" General Options
" -------------------------------------
" automatically set up vundle and install all bundles if vundle is not installed
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
	let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'bling/vim-airline'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'ggreer/the_silver_searcher'
Plugin 'kien/ctrlp.vim'
Plugin 'rbgrouleff/bclose.vim'
" Plugin 'rking/ag.vim'

" I love this, but it is so slow
" Plugin 'myusuf3/numbers.vim'

" Inline git status
Plugin 'airblade/vim-gitgutter'

" Git integration
Plugin 'tpope/vim-fugitive'

" General Options
" -------------------------------------
set t_Co=256                          " enable 256 colors
set mouse=a                           " make sure mouse is used in all cases.
set autoread                          " detect external changes
set scrolloff=5                       " lines between cursor and edge
set autoindent
set showmode
set hidden
set showcmd                           " display current command
set cmdheight=1                       " set the command height
set shortmess+=I                      " disable the welcome screen
set complete+=k                       " enable dictionary completion
set wildmenu  			      " cmd line completion
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*.pyo,*.so,*.sw*,__pycache__
set ttyfast
set ruler                             " ruler display in status line
set backspace=2                       " full backspacing capabilities
set backspace=indent,eol,start        " behave like a normal backspace
set laststatus=2                      " always show a status line
set number                            " show number line
set magic                             " enables regex highlight?
set ttimeoutlen=50
set timeoutlen=300	  	      " esc delay
set clipboard=unnamed                 " yank+paste use the osx clipboard

" undofile
" -------------------------------------
if exists("+undofile")
  " Uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " (This is only present in 7.3+)
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif


" tabs and indenting
" -------------------------------------
" should be taken care of by vim-sleuth 
set expandtab                         " replace tabs with spaces
set shiftwidth=4
set softtabstop=4
set autoindent                        " auto indents next new line
set shiftround                        " better tab aligning


" searching
" -------------------------------------
set hlsearch                         " highlight search results
set incsearch                         " increment search
set ignorecase                        " case-insensitive search
set smartcase                         " upper-case sensitive search
set gdefault
set showmatch                         " show matching brackets (),{},[]


"  wrap like other editors
" -------------------------------------
set wrap                              " word wrap
set lbr                               " line break


" no bells
" -------------------------------------
set noerrorbells visualbell t_vb =
autocmd GUIEnter * set visualbell t_vb=


" syntax highlighting
" -------------------------------------
syntax on
syntax enable
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
"highlight MatchParen cterm=bold ctermfg=Grey ctermbg=DarkGrey


" custom keybindings
" -------------------------------------
" space is leader (all hail space)
let mapleader = "\<Space>"

" When pasting in visual mode, reselect and yank so you don't overwrite the register
xnoremap p pgvy

" map :bd to :Bclose so spilts don't close with bd
cabbrev bd Bclose

" save quicker
" Add SyntasticCheck here as a hotfix unitl I can debug why autosave is broken
nnoremap <Leader>w :w<CR> :SyntasticCheck<CR>

" v to expand selection, <C-v> to reduce
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" hjkl only - prevents scrolling over to next line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" remap H to go to beginning of line, L to end
nnoremap H ^
nnoremap L $

" halp
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" autocorrect plx
"nnoremap ; :

" get out of insert mode
inoremap jj <ESC>
inoremap jk <ESC>
"inoremap kj <ESC>
"inoremap kk <ESC>

" allow writing root files when forgetting to sudo
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" keep macro window from popping up
map q: :q
map q <Nop>

" Shortcut to shut off Numbers for huge files
" nnoremap <F3> :NumbersToggle<CR>

" auto commands
" -------------------------------------
" turn hash bangs into executeables automatically
au BufWritePost * if getline(1) =~ "^#!" | silent :!chmod +x <afile>
au BufWritePost .vimrc source %

" save last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif "

" disable auto-commenting
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" save on lose focus
au FocusLost * :wa
set wildignore+=*.lib,*.dll,*.exe,*.o,*.obj,*.pyc,*.pyo,*.png,*.gif,*.jpg,*.jpeg,*.bmp,*.tiff " ignore filetypes for auto complete

" this function should auto-toggle paste mode when using cmd+v to paste
" function! WrapForTmux(s)
"   if !exists('$TMUX')
"     return a:s
"   endif

"   let tmux_start = "\<Esc>Ptmux;"
"   let tmux_end = "\<Esc>\\"

"   return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
" endfunction

" let &t_SI .= WrapForTmux("\<Esc>[?2004h")
" let &t_EI .= WrapForTmux("\<Esc>[?2004l")

" function! XTermPasteBegin()
"   set pastetoggle=<Esc>[201~
"   set paste
"   return ""
" endfunction

" inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" plugin settings
" -------------------------------------

" ctrl p uses gitignore
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" let g:ctrlp_use_caching = 0
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Airline Setting
" ---------------------------------
let g:airline_theme = 'powerlineish'
let g:airline#extensions#whitespace#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1

" Syntastic settings
" ----------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs=1
let syntastic_mode_map = { 'passive_filetypes': ['html', 'less'] }
let g:syntastic_python_checkers=['flake8', 'python']

" Ag/grep searching settings
" --------------------------------
" Use The Silver Searcher
" brew install the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column' " Use in Ack.vim
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " Use in CtrlP
  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  " bind \ (backward slash) to grep shortcut
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

" open line in quickfix window in new vertical split
autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

