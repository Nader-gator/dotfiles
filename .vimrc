" vim:fdm=marker
" Install plugin manager if it doesnt exist {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}
" Plugins {{{
call plug#begin()

" UI
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'mhinz/vim-startify'

" syntax and autofill
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'w0rp/ale'
Plug 'Nader-gator/vim-polyglot'
Plug 'luochen1990/rainbow'
Plug 'andymass/vim-matchup'

" Themses and visual
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'TaDaa/vimade'

" Motion and navigation
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'

" ease of use
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vimlab/split-term.vim'
Plug 'Galooshi/vim-import-js'
Plug 'tpope/vim-surround'
Plug 'gu-fan/colorv.vim'
Plug 'vim-scripts/LineJuggler'
Plug 'inkarkat/vim-ingo-library'
Plug 'tpope/vim-eunuch'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'FooSoft/vim-argwrap'
Plug 'junegunn/vim-easy-align'

" invisible help
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-sensible'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
call plug#end()
" }}}
" FZF optiona and DEVICON function {{{
let $FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'
let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

function! Fzf_files_with_dev_icons(default_command,optional)
   "let l:fzf_files_options = '--preview "rougify {2..-1} | head -'.&lines.'"'
    if a:optional == 1
     let l:fzf_files_options = '--preview "bat --color always --style numbers {2..} | head -'.&lines.'"'
    elseif a:optional == 0
     let l:fzf_files_options = ''
    endif
   function! s:edit_devicon_prepended_file(item)
    let l:file_path = a:item[4:-1]
    execute 'silent e' l:file_path
  endfunction
   call fzf#run({
        \ 'source': a:default_command.' | devicon-lookup',
        \ 'sink':   function('s:edit_devicon_prepended_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction
nmap <leader>ff :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND,0)<CR>
nmap <leader>fj :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND,1)<CR>

" git diff {{{
 "function! Fzf_git_diff_files_with_dev_icons()
  "let l:fzf_files_options = '--ansi --preview "sh -c \"(git diff --color=always -- {3..} | sed 1,4d; bat --color always --style numbers {3..}) | head -'.&lines.'\""'
   "function! s:edit_devicon_prepended_file_diff(item)
    "echom a:item
    "let l:file_path = a:item[7:-1]
    "echom l:file_path
    "let l:first_diff_line_number = system("git diff -U0 ".l:file_path." | rg '^@@.*\+' -o | rg '[0-9]+' -o | head -1")
     "execute 'silent e' l:file_path
    "execute l:first_diff_line_number
  "endfunction
   "call fzf#run({
        "\ 'source': 'git -c color.status=always status --short --untracked-files=all | devicon-lookup',
        "\ 'sink':   function('s:edit_devicon_prepended_file_diff'),
        "\ 'options': '-m ' . l:fzf_files_options,
        "\ 'down':    '40%' })
"endfunction
" }}}
 " Open fzf Files " Open fzf Files
"map <C-d> :call Fzf_git_diff_files_with_dev_icons()<CR>
"map <C-g> :call Fzf_files_with_dev_icons("git ls-files \| uniq")<CR>
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
" COC instal script {{{
"
"CocInstall coc-json coc-tsserver coc-html woc-css coc-vetur coc-phpls coc-java coc-solargraph coc-rls coc-yaml coc-python coc-highlight coc-emmet coc-snippets
"}}}
" functions {{{
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
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
"}}}

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
set colorcolumn=80


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
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"line number
:set number relativenumber
:augroup numbertoggle
:autocmd!
:autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"LatexPreview options
autocmd Filetype tex setl updatetime=3
let g:livepreview_previewer = 'open -a Preview'
nmap <leader>ltx :LLPStartPreview<cr>

"___1___Fuzzy finder
nmap <C-f> :Files<cr>|    " fuzzy find files in the working directory (where you launched Vim from)
nmap <leader>fl :Lines<cr>|   " fuzzy find lines in the current file
nmap <leader>fb :Buffers<cr>|  " fuzzy find an open buffer
nmap <leader>ft :Tags<cr>|     " fuzzy find text in the working directory
nmap <leader>fc :Commands<cr>| " fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)

"___2___ ALE
"goto definition
nmap <leader>dn :ALEGoToDefinition<cr>|          " Open the definition of the symbol under the cursor.
nmap <leader>dt :ALEGoToDefinitionInTab<cr>|    " The same, but for opening the file in a new tab.
nmap <leader>dh :ALEGoToDefinitionInSplit<cr>|  " The same, but in a new split.
nmap <leader>dv :ALEGoToDefinitionInVSplit<cr>| " The same, but in a new vertical split.
"let g:ale_fixers = ['prettier','remove_trailing_lines', 'trim_whitespace','autopep8']
let g:ale_fixers = {
\   '*': ['prettier','remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint','prettier'],
\   'python': ['yapf'],
\   'ruby': ['standardrb']
\   }
let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fix_on_save = 1

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
" add script for opening vimrc in directory
" add rougify gem script
" add rust devicon-lookup
" add rust bat
" add prettier

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
nmap W :w<cr>

"clipboard
set clipboard=unnamed

"easymotion
nmap <leader>q <Plug>(easymotion-bd-w)
let g:EasyMotion_keys='edcrfvtgbyhnujm'

"copy pasting
nnoremap d "ad
nnoremap <leader>p "ap

"canceling importjs
nmap <leader>g g

"moving lines
nmap <A-d> [e
nmap <A-f> ]e
"color edit
nmap <leader>ec :ColorVEdit

"newline
imap <A-o> <esc>o

"emmet
let g:user_emmet_leader_key='-'

"not hide tags in markdown
let g:indentLine_fileTypeExclude = ['markdown']

" arg wrap
nnoremap <leader>w :ArgWrap<CR>

"easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"fadelevel
let g:vimade = {}
let g:vimade.fadelevel = 0.8
