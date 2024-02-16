let mapleader = " "
set timeoutlen=500

set tabstop=2
set scrolloff=15
set shiftwidth=2

set syntax=ON
set filetype=ON

set number
set expandtab
set relativenumber
set splitbelow
set listchars="eol:$,tab:>-,trail:~,extends:>,precedes:<"

" Explorer
map <leader>e :Ex<Cr>

" Buffer navigation
map bn :bn<Cr>
map bp :bp<Cr>
map bd :bd<Cr>
map bl :ls<Cr>
