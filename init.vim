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
filetype indent on

let _curfile=expand("%:r")
if _curfile == 'makefile' || 'Makefile'
  set noexpandtab
endif

autocmd BufWritePre * :%s/\s\+$//ge

nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,ff :<C-u>:VimFiler<CR>
nnoremap <silent> ,fe :<C-u>VimFilerExplore -split -winwidth=30 -find -no-quit<CR>


function! s:get_syn_id(transparent)
let synid = synID(line("."), col("."), 1)
  if a:transparent
return synIDtrans(synid)
  else
  return synid
  endif
  endfunction
  function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
    \ "name": name,
      \ "ctermfg": ctermfg,
      \ "ctermbg": ctermbg,
      \ "guifg": guifg,
      \ "guibg": guibg}
      endfunction
      function! s:get_syn_info()
      let baseSyn = s:get_syn_attr(s:get_syn_id(0))
      echo "name: " . baseSyn.name .
      \ " ctermfg: " . baseSyn.ctermfg .
      \ " ctermbg: " . baseSyn.ctermbg .
      \ " guifg: " . baseSyn.guifg .
      \ " guibg: " . baseSyn.guibg
      let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
      echo "link to"
      echo "name: " . linkedSyn.name .
      \ " ctermfg: " . linkedSyn.ctermfg .
      \ " ctermbg: " . linkedSyn.ctermbg .
      \ " guifg: " . linkedSyn.guifg .
      \ " guibg: " . linkedSyn.guibg
      endfunction
      command! SyntaxInfo call s:get_syn_info()
