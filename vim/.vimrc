let mapleader = " "
set timeoutlen=500

syntax on

set tabstop=2
set scrolloff=15
set shiftwidth=2

set nobackup
set nowritebackup

set number
set expandtab
set relativenumber
set splitbelow
set splitright
set cursorline
set listchars="eol:$,tab:>-,trail:~,extends:>,precedes:<"

" Explorer
map <leader>e :Ex<Cr>

" Buffer navigation
map <c-n> <cmd>bn<cr>
map <c-p> <cmd>bp<cr>
map <leader>b <cmd>bp<bar>sp<bar>bn<bar>bd<cr>zz