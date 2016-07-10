set nocompatible
filetype off

"---------------------------
"  Vundle
"---------------------------

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" code folding
Plugin 'tmhedberg/SimpylFold'
" python
Plugin 'vim-scripts/indentpython.vim'
" code completion
Bundle 'Valloric/YouCompleteMe'
" syntax checking
Plugin 'scrooloose/syntastic'
" file browsing
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Indent line
Plugin 'Yggdroot/indentLine'
" Git Gutter
Plugin 'airblade/vim-gitgutter'
" Solarized colors
Plugin 'altercation/vim-colors-solarized'
" Powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Ansible
Plugin 'pearofducks/ansible-vim'
" Golang
Plugin 'fatih/vim-go'
" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" comment automation
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required

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
set colorcolumn=80
if has('gui_running')
   set background=dark
   colorscheme solarized
   let g:solarized_contrast="high"
   let g:solarized_visibility="high"
   set guifont=Sauce_Code_Powerline_ExtraLight:h11
endif
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
let g:SimpylFold_docstring_preview=1

"---------------------------
" code completion
"---------------------------
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


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
" NERDTree settings
"---------------------------
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let NERDTreeShowHidden=1

"---------------------------
" Ansible
"---------------------------
let g:ansible_attribute_highlight = "ab"
let g:ansible_extra_keywords_highlight = 1

"---------------------------
" golang
"---------------------------
" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" basic editing
au BufNewFile,BufRead *.go set tabstop=4
au BufNewFile,BufRead *.go set softtabstop=4
au BufNewFile,BufRead *.go set shiftwidth=4
au BufNewFile,BufRead *.go set textwidth=79
au BufNewFile,BufRead *.go set autoindent
au BufNewFile,BufRead *.go set fileformat=unix
au BufNewFile,BufRead *.go set encoding=utf-8

"---------------------------
" syntastic
"---------------------------
" avoid conflicts with vim-go
let g:go_fmt_fail_silently = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

"---------------------------
" NERDcommenter
"---------------------------
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
