" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

  " 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

  " もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

nnoremap j gj
nnoremap k gk

noremap <silent> <C-c> <C-[>
cnoremap <silent> <C-c> <esc>
inoremap <silent> <C-c> <esc>

noremap <silent> <C-l> $
noremap <silent> <C-h> 0

cmap <C-n> vs<cr>:sp<cr><C-w>l:sp<cr><C-w>j:ter<cr><C-\><C-n>


syntax on
set number
set title
set ambiwidth=double
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set hidden
set history=50
set wildmenu
set noswapfile
set nobackup
set showcmd
set showmatch
set laststatus=2
set wildmode=list:longest
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set virtualedit=onemore
set autoindent
set pumheight=10
set updatetime=500
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P

filetype indent on

let _curfile=expand("%:r")
if _curfile == 'makefile' || 'Makefile'
  set noexpandtab
endif

autocmd BufWritePre * :%s/\s\+$//ge

let g:python3_host_prog='/usr/bin/python3'
