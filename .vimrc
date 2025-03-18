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

" 行番号を表示
set number

" タイトルバーを無効化
set notitle

" 全角文字の扱いをダブル幅にする
set ambiwidth=double

" タブ幅を4に設定
set tabstop=4

" タブをスペースに展開
set expandtab

" シフト幅を4に設定
set shiftwidth=4

" スマートインデントを有効化
set smartindent

" 不可視文字を表示
set list

" 不可視文字の表示設定
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" 数値形式を16進数にする
set nrformats=hex

" 変更されたバッファを隠す
set hidden

" 仮想編集をブロックモードで有効化
set virtualedit=block

" カーソルが行末を越えて移動できるようにする
set whichwrap=b,s,<,>,[,],h,l

" Backspaceキーの動作設定
set backspace=indent,eol,start

" ワイルドメニューを有効化
set wildmenu

" 大文字小文字を区別しない検索
set ignorecase

" 大文字小文字を区別するスマート検索
set smartcase

" ファイル末尾まで検索を継続
set wrapscan

" 検索語をハイライト表示
set hlsearch

" 対応する括弧を強調表示
set showmatch

" 対応する括弧の表示時間
set matchtime=1

" タブラインを非表示
set showtabline=0

" ターミナルGUIカラーを有効化
set termguicolors

" ウィンバーを非表示
" set winbar=

" ステータスラインを非表示
set laststatus=0
set statusline=

" モード表示を無効化
" set noshowmode
