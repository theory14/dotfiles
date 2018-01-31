set nocompatible
filetype off

"---------------------------
" General settings
"---------------------------
filetype indent plugin on
syntax on
let mapleader=" "
set nu
set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
set showmatch
" get rid of scrollbars
set guioptions-=R
set guioptions-=L
set guioptions-=r
set guioptions-=l
" get rid of trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
" color bad whitspace
highlight BadWhitespace ctermbg=red guibg=red
" backup/swap files not really needed
set nobackup
set nowb
set noswapfile
set laststatus=2

"---------------------------
" code folding
"---------------------------
set foldmethod=indent
set foldlevel=99

"---------------------------
" python settings
"---------------------------
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix
au BufNewFile,BufRead *.py set encoding=utf-8
au BufRead,BufNewFile *.py match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/
" teach vim about virtualenv
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"---------------------------
" yaml settings
"---------------------------
au BufNewFile,BufRead *.yaml,*.yml set tabstop=2
au BufNewFile,BufRead *.yaml,*.yml set softtabstop=2
au BufNewFile,BufRead *.yaml,*.yml set shiftwidth=2
au BufNewFile,BufRead *.yaml,*.yml set textwidth=79
au BufNewFile,BufRead *.yaml,*.yml set expandtab
au BufNewFile,BufRead *.yaml,*.yml set autoindent
au BufNewFile,BufRead *.yaml,*.yml set fileformat=unix
au BufNewFile,BufRead *.yaml,*.yml set encoding=utf-8
au BufRead,BufNewFile *.yaml,*.yml match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.yaml,*.yml, match BadWhitespace /\s\+$/

"---------------------------
" golang
"---------------------------
au BufNewFile,BufRead *.go set tabstop=8
au BufNewFile,BufRead *.go set softtabstop=8
au BufNewFile,BufRead *.go set shiftwidth=8
au BufNewFile,BufRead *.go set textwidth=79
au BufNewFile,BufRead *.go set autoindent
au BufNewFile,BufRead *.go set fileformat=unix
au BufNewFile,BufRead *.go set encoding=utf-8
