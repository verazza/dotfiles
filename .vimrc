" wsl
if (exists('$WSL_DISTRO_NAME') || (has('win32') || has('win64'))) && filereadable(expand('$HOME/.wsl/.vimrc'))
  source ~/.wsl/.vimrc
else
  set clipboard=unnamedplus
endif

" リーダーキーをスペースに設定
let mapleader = "\<space>"

imap jj <Esc>
nnoremap <Leader>qq :qall<CR>

set mouse=a

set number
set notitle
set ambiwidth=double
set tabstop=2
set expandtab
set shiftwidth=2
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set nrformats=hex
set hidden
set virtualedit=block
set whichwrap=b,s,<,>,[,],h,l
set backspace=indent,eol,start
set wildmenu
set ignorecase
set smartcase
set wrapscan
set hlsearch
set showmatch
set matchtime=1
set showtabline=0
set termguicolors
" set winbar=
set laststatus=0
set statusline=
" set noshowmode
