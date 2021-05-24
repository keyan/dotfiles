set nocompatible "be iMproved
filetype off " necessary to make sure vundle does something
set modelines=0 "security hole involving modelines, probably patched by now?

" General Options
" -------------------------------------
" Automatically set up vundle and install all bundles if vundle is not installed.
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone http://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle

	let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugins
" -------------------------------------
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'ggreer/the_silver_searcher'
Plugin 'kien/ctrlp.vim'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree'
Plugin 'joshdick/onedark.vim'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-abolish'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'vim-python/python-syntax'
" Plugin 'davidhalter/jedi-vim'
Plugin 'leafgarland/typescript-vim'
" Enhanced C++ syntax highlighting
Plugin 'bfrg/vim-cpp-modern'
" Autogenerate/updated ctags
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'rakr/vim-one'

" Turns on filetype detection and filespecific indentation.
" Must go after the Vundle configuration above in order to use `ftdetect` dirs.
filetype plugin indent on
filetype plugin on

" General Options
" -------------------------------------
set t_Co=256                          " enable 256 colors
set mouse=a                           " make sure mouse is used in all cases.
set autoread                          " detect external changes
set scrolloff=5                       " lines between cursor and edge
set showmode
set hidden                            " allow for hidden open files in buffers
set showcmd                           " display current command
set cmdheight=1                       " set the command height
set shortmess+=I                      " disable the welcome screen
set complete+=k                       " enable dictionary completion
set wildmenu  			      " cmd line completion
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*.pyo,*.so,*.sw*,__pycache__
" set ttyfast
set ruler                             " ruler display in status line
set backspace=2                       " full backspacing capabilities
set backspace=indent,eol,start        " behave like a normal backspace
set laststatus=2                      " always show a status line
set number                            " show number line
set magic                             " enables regex highlight
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
set expandtab                         " replace tabs with spaces
set shiftwidth=4
set softtabstop=4
set autoindent                        " auto indents next new line
set shiftround                        " better tab aligning
set smartindent

" Indent only once after an open paren, see :help ft-python-indent
let g:pyindent_open_paren = '&sw'


" searching
" -------------------------------------
set hlsearch                          " highlight search results
set incsearch                         " increment search
set ignorecase                        " case-insensitive search
set smartcase                         " upper-case sensitive search
set gdefault
set showmatch                         " show matching brackets (),{},[]
" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>


" Definition (Ctags) and documentation (jedi) lookups
" -------------------------------------
" Move up from the pwd looking for the tags file
set tags=./tags,tags;$HOME
" Open Ctags definition in a new vertical split to the right
map <C-\> :vsp <CR><C-w><S-l> :exec("tag ".expand("<cword>"))<CR>
" I use shift-k for Ag search, so override the default
let g:jedi#documentation_command = "F"

let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
" Ignore Golang projects which I use godef for
" let g:gutentags_exclude_project_root = ['main.go']

" Cache all tag files in the same place
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
" Allow tag cache clearing
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" Making Gutentags faster by ignoring a lot of unnecessary filetypes.
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

"  wrap like other editors
" -------------------------------------
set wrap                              " word wrap
set lbr                               " line break


" no bells
" -------------------------------------
set noerrorbells visualbell t_vb =
autocmd GUIEnter * set visualbell t_vb=


" colors and syntax highlighting
" -------------------------------------
" Rainbow parens
let g:rainbow_active = 0

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" python-syntax options
let g:python_highlight_all = 1

set termguicolors
syntax on
syntax enable
set background=dark
colorscheme one
" set background=light
" colorscheme onedark

" code completion
" -------------------------------------
" Override supertab's default and use omni-completion when possible
let g:SuperTabDefaultCompletionType = "context"
" autocmd FileType *
" \ if &omnifunc != '' |
" \   call SuperTabChain(&omnifunc, "<c-p>") |
" \ endif


" custom keybindings
" -------------------------------------
" Space is leader (all hail space)
let mapleader = "\<Space>"

" When pasting in visual mode, reselect and yank so you don't overwrite the register
xnoremap p pgvy

" Buffer closing
" map :bd to :Bclose so spilts don't close with bd
cabbrev bd Bclose
map <leader>b :Bclose<CR>


" Save quicker
nnoremap <Leader>w :w<CR>

" Reload quicker
nnoremap <Leader>e :e<CR>

" Add SyntasticCheck here as a hotfix unitl I can debug why autosave is broken
" Fast execution of pylint, so I don't include it in the global check list and
" slow down saves too much.
" noremap <Leader>l :SyntasticCheck pylint<CR>
" noremap <Leader>l :SyntasticCheck<CR>

" Run spellcheck and highlight unknown words
:command Spellcheck setlocal spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline

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

" get out of insert mode
inoremap jj <ESC>
inoremap jk <ESC>

" allow writing root files when forgetting to sudo
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" I always mistype :wq
command Wq wq
command WQ wq
command Q q
command Qa qa
" quit easy, quit often
nnoremap <Leader>q :q<CR>

map <leader>k :NERDTree<CR>
map <leader>v :vsp<CR>
map <leader>s :sp<CR>

" Custom CTRL commands
" quick braces, CTRL+F for {}
imap <C-F> {<CR>}<C-O>O
" quick parens, CTRL+D for ()
imap <C-D> (<CR>)<C-O>O
" execute current file with python3
nnoremap <C-K> :!clear; python3 %<CR>

" Move up and down in autocomplete with <c-j> and <c-k>
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Close the preview window easily
map <leader>p :pclose<CR>

" Quick and dirty latex recompile, ignore if accidently used on non-tex file
" map <leader>l :! [ % == *.tex ] && pdflatex %<CR><CR>
map <leader>l :! pdflatex %<CR><CR>

" Add newline without going into insert mode, stay on current line
nnoremap <C-J> a<CR><Esc>k$

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
" ignore filetypes for auto complete
set wildignore+=*.lib,*.dll,*.exe,*.o,*.obj,*.pyc,*.pyo,*.png,*.gif,*.jpg,*.jpeg,*.bmp,*.tiff


" Ctrl-P Settings
" -------------------------------------
set runtimepath^=~/.vim/bundle/ctrlp.vim


" Airline Settings
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
let g:syntastic_auto_loc_list = 1
" I want this but it is sooooo slow
" let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs=1
let syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'passive_filetypes': ['html', 'less', 'go']}

" Python
let g:syntastic_python_checkers=['flake8', 'python', 'python3']
let g:syntastic_python_flake8_args = "--max-line-length=120"
let g:syntastic_python_python_exec = '/usr/local/bin/python3.7'
" Switch between linters for python2/3
function Py2()
  let g:syntastic_python_python_exec = '/usr/local/bin/python2.7'
endfunction

function Py3()
  let g:syntastic_python_python_exec = '/usr/local/bin/python3.7'
endfunction

" CPP
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'

" Typescript
let g:typescript_indent_disable = 1

" Golang
" https://github.com/fatih/vim-go/blob/master/doc/vim-go.txt
" Use godef, not guru for definition search
" let g:go_def_mode = 'godef'
" Pass additional options to the gofmt on-save command
let g:go_fmt_options = {'gofmt': '-s'}
" Gopls support
let g:go_gopls_enabled = 1
let g:go_gopls_options = ['-remote=auto']
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_referrers_mode = 'gopls'
" Run GoImports on save, which also runs gofmt
" Might want to disable this because it is slow on large codebases
" let g:go_fmt_command = "goimports"
" let g:go_debug = ['lsp', 'shell-commands']


" Ag/grep searching settings
" --------------------------------
" Use The Silver Searcher
" brew install the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column' " Use in Ack.vim
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " Use in CtrlP
  " bind K and M to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  nnoremap M :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  " bind \ (backward slash) to grep shortcut
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

" open line in quickfix window in new vertical split
autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L


" Temporary hacks
" --------------------------------
" Regardless of installed plugins, silently execute python3 once on the top of your vimrc:

if has('python3')
  silent! python3 1
endif
