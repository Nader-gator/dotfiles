" vim:fdm=marker
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Plugins {{{
call plug#begin()
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'Nader-gator/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'cohama/lexima.vim'
Plug 'SirVer/ultisnips'
Plug 'vimlab/split-term.vim'
Plug 'luochen1990/rainbow'
Plug 'easymotion/vim-easymotion'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Galooshi/vim-import-js'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
call plug#end()
" }}}
" FZF WITH DEVICON {{{
nnoremap <silent> <leader>fe :call Fzf_dev()<CR>
function! Fzf_dev()
  let l:fzf_files_options = '--preview "rougify {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction
" }}}
" airline {{{
function! WindowNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_c', '%{tabpagewinnr(tabpagenr())}')
    return 0
endfunction
call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile
" }}}

set splitbelow
set splitright
set mouse=a
set fileignorecase
set wildignorecase

" color theme
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" colors
syntax on 
colorscheme onedark
highlight CursorLineNr guifg=#e28409
let g:rainbow_active = 1


"git gutter
set updatetime=100
nmap <Leader>gd <Plug>GitGutterPreviewHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk


" indent line markers
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'


"tabs
filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

"line number
:set number relativenumber
:augroup numbertoggle
:autocmd!
:autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"___1___Fuzzy finder
nmap <leader>ff :Files<cr>|    " fuzzy find files in the working directory (where you launched Vim from)
nmap <leader>fl :BLines<cr>|   " fuzzy find lines in the current file
nmap <leader>fb :Buffers<cr>|  " fuzzy find an open buffer
nmap <leader>ft :Tags<cr>|     " fuzzy find text in the working directory
nmap <leader>fc :Commands<cr>| " fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)

"___2___ ALE
"goto definition
nmap <leader>dn :ALEGoToDefinition<cr>|          " Open the definition of the symbol under the cursor.
nmap <leader>dt :ALEGoToDefinitionInTab<cr>|    " The same, but for opening the file in a new tab.
nmap <leader>dh :ALEGoToDefinitionInSplit<cr>|  " The same, but in a new split.
nmap <leader>dv :ALEGoToDefinitionInVSplit<cr>| " The same, but in a new vertical split.

"hover info
nmap <leader>hov :ALEHover<cr>| " The same, but in a new vertical split.

"toggle linting
nmap <leader>tl :ALEToggle<cr>| " Toggle ALE linting

"___3___Commenter
nmap <C-c> <Plug>NERDCommenterToggle

"___4___NERDtree
nmap <leader>nt :NERDTreeToggle<cr>
let NERDTreeMapOpenSplit='h'
let NERDTreeMapActivateNode='l' 
let NERDTreeMapOpenVSplit='v'

"___5___COC
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

"TODO script to install lang servers
" lightline
" add script for opening vimrc in directory
" add nerdtree left right keys

"create new file and directory
function s:MKDir(...)
    if         !a:0 
           \|| isdirectory(a:1)
           \|| filereadable(a:1)
           \|| isdirectory(fnamemodify(a:1, ':p:h'))
        return
    endif
    return mkdir(fnamemodify(a:1, ':p:h'), 'p')
endfunction
command -bang -bar -nargs=? -complete=file E :call s:MKDir(<f-args>) | e<bang> <args>

" shortcut to make new file
nmap <C-n> :E 
nnoremap <Space> :noh<cr>
set ignorecase

" terminals
nmap <leader>th :Term<cr>
nmap <leader>tv :VTerm<cr>
nmap <leader>tt :TTerm<cr>
nmap <leader>tn :terminal<cr>
"easier term movement
nmap <A-h> <C-w>h
nmap <A-j> <C-w>j
nmap <A-k> <C-w>k
nmap <A-l> <C-w>l

"OUT OUT OUT
nmap Q :q<cr>

"clipboard
set clipboard=unnamed 

let $FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'
let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

"easymotion
nmap <leader>w <Plug>(easymotion-bd-w)

"copy pasting
nnoremap y "ay
nnoremap p "ap
nnoremap <leader>p p

"canceling importjs
nmap <leader>g g
