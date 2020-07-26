cnoremap <C-w> <S-Right>
cnoremap <C-b> <S-Left>
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
cnoremap <c-b> <home>
cnoremap <c-e> <end>

highlight CursorLineNr guifg=#e28409
set splitbelow
set splitright
set mouse=a
set fileignorecase
set wildignorecase
set ignorecase
nnoremap <leader>v :e ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
map <BS> \
map <BS><BS> \\
nnoremap <leader>mv :tab split<CR>
nmap <leader>tn :tabnew<cr>
nnoremap * m`:keepjumps normal! *``<cr>
syntax on
set colorcolumn=80
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set number relativenumber

nnoremap <Space> :noh<cr>
nmap Q :q<cr>
nmap ]w :w<cr>

nnoremap  Y  "+Y 
vnoremap  y  "+y
nnoremap  y  "+y
nnoremap  yy  "+yy
nnoremap <leader>p "+p
