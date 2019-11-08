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
"Plug 'mhinz/vim-grepper'


" syntax and autofill
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'w0rp/ale', {'commit': '1ee56713b8f9cfd0faa99dd7930437fa7ed986b0'}
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
" Plug 'TaDaa/vimade'
Plug 'junegunn/goyo.vim'

" Motion and navigation
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'wesQ3/vim-windowswap'

" ease of use
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'scrooloose/nerdcommenter'
Plug 'tomtom/tcomment_vim'
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
"Plug 'vim-scripts/greplace.vim'
Plug 'brooth/far.vim'
Plug 'jeetsukumaran/vim-pythonsense'


" invisible help
Plug 'tpope/vim-sensible'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'
"Plug 'ryvnf/readline.vim'
Plug 'cohama/lexima.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'rizzatti/dash.vim'
Plug 'ianding1/leetcode.vim'

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

let g:fzf_layout = { 'window': 'call FloatingFZF()' }
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

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
        \ 'window': 'call FloatingFZF()'})
endfunction
nmap <leader>fj :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND,0)<CR>
nmap <leader>ff :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND,1)<CR>

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
    " call builder.add_section('airline_c', '%{tabpagewinnr(tabpagenr())}')
    return 0
endfunction
" call airline#add_statusline_func('WindowNumber')
" call airline#add_inactive_statusline_func('WindowNumber')
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
" }}}
" COC instal script {{{
"
"CocInstall coc-json coc-tsserver coc-html woc-css coc-vetur coc-phpls coc-java coc-solargraph coc-rls coc-yaml coc-python coc-highlight coc-emmet coc-snippets
"}}}
" functions {{{
function! s:MKDir(...)
    if         !a:0
           \|| isdirectory(a:1)
           \|| filereadable(a:1)
           \|| isdirectory(fnamemodify(a:1, ':p:h'))
        return
    endif
    return mkdir(fnamemodify(a:1, ':p:h'), 'p')
endfunction
command! -bang -bar -nargs=? -complete=file E :call s:MKDir(<f-args>) | e<bang> <args>
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
" simple vim changes
nnoremap <leader>v :e ~/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
map <BS> \
nnoremap * m`:keepjumps normal! *``<cr>

let g:xml_syntax_folding = 0

let g:leetcode_solution_filetype='python'
let g:leetcode_username='nader-gator'

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
set colorcolumn=100

" disable rainbowing html tags
let g:rainbow_conf = {
\	'separately': {
\		'html': 0,
\	}
\}
" to keep all emmet tools in rails/django
au BufReadPost *.html set filetype=html

"git gutter
set updatetime=400
nmap <Leader>gd <Plug>(GitGutterPreviewHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
let g:gitgutter_preview_win_floating = 0


" indent line markers
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_leadingSpaceEnabled = 1
autocmd FileType nerdtree IndentLinesDisable
let g:indentLine_leadingSpaceChar = '·'


"tabs
filetype plugin indent on
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"line number
set number relativenumber
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"LatexPreview options
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'
nmap <leader>ltx :LLPStartPreview<cr>

"___1___Fuzzy finder
nmap <C-f> :Files<cr>|    " fuzzy find files in the working directory (where you launched Vim from)
nmap <leader>fl :Lines<cr>|   " fuzzy find lines in the current file
nmap <leader>fb :Buffers<cr>|  " fuzzy find an open buffer
nmap <leader>ft :Tags<cr>|     " fuzzy find text in the working directory
nmap <leader>fc :Commands<cr>| " fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)
nmap <leader>fg :Ag<cr>
command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

"___2___ ALE
"goto definition
nmap <leader>dn <Plug>(coc-definition)
nmap <leader>dt :tabnew<cr> <Plug>(coc-definition)
nmap <leader>ds :split<cr> <Plug>(coc-definition)
nmap <leader>dv :vsplit<cr> <Plug>(coc-definition)
let i = 1
while i <= 20
    execute 'nnoremap <Leader>' . i . '<Space>' . ' :' . i . 'wincmd w<CR>'
    execute 'nnoremap ]' . i . '<Space> ' .  i . 'gt'
    execute 'nmap <Leader>' . 'di' . i . '<Space>' . ' :let buffno=bufnr("%")<cr>:let linepos=line(".")<cr>:let colpos=col(".")<cr> :' . i . 'wincmd w<cr>:execute("buffer ".buffno)<cr>:call cursor(linepos,colpos)<cr>' . ' <Plug>(coc-definition)'
    let i = i + 1
endwhile

"nmap <leader>tje :let buffno=bufnr('%')<cr>:let linepos=line('.')<cr>:let colpos=col('.')<cr> :2wincmd w<cr>:execute("buffer ".buffno)<cr>:call cursor(linepos,colpos)<cr> <Plug>(coc-definition)
"nmap <silent> gd :split<cr> <Plug>(coc-definition)

"let g:ale_fixers = ['prettier','remove_trailing_lines', 'trim_whitespace','autopep8']
let g:ale_fixers = {
\   '*': ['prettier','remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint','prettier'],
\   'python': ['autopep8'],
\   'ruby': ['standardrb']
\   }
let g:ale_linters = {'ruby': ['standardrb'],
            \   'python':['']}
let g:ale_completion_enabled = 0

let g:ale_fix_on_save = 1

nmap <leader>fd :let b:ale_fix_on_save = 0<cr>
nmap <leader>fe :let b:ale_fix_on_save = 1<cr>
"

"toggle linting
nmap <leader>tl :ALEToggle<cr>| " Toggle ALE linting

"___3___Commenter
" nmap <C-c> <Plug>NERDCommenterToggle
nmap <C-c> gcc

"___4___NERDtree
nmap <leader>nt :NERDTreeToggle<cr>
let NERDTreeMapOpenSplit='s'
let NERDTreeMapActivateNode='l'
let NERDTreeMapOpenVSplit='v'
nmap <Leader>r :NERDTreeRefreshRoot<cr>

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
nmap <leader>ts :Term<cr>
nmap <leader>tv :VTerm<cr>
nmap <leader>tt :TTerm<cr>
nmap <leader>ter :terminal<cr>

nmap <leader>tn :tabnew<cr>

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
nnoremap dd "add
nnoremap <leader>p "ap

"canceling importjs
nmap <leader>g g

"moving lines
nmap <A-d> [e
nmap <A-f> ]e

"color edit
nmap <leader>ec :ColorVEdit<cr>

"emmet
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
let g:user_emmet_mode='i'
autocmd FileType html,css EmmetInstall

"not hide tags in markdown
let g:indentLine_fileTypeExclude = ['markdown','nerdtree']

" arg wrap
nnoremap <leader>w :ArgWrap<CR>

"easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"fadelevel
let g:vimade = {}
let g:vimade.fadelevel = 0.7

"keep md upen
let g:mkdp_auto_close = 0

"compile and run
autocmd FileType c nmap <leader>m :!gcc % && ./a.out<cr>
autocmd FileType cpp nmap <leader>m :!g++ % && ./a.out<cr>
autocmd FileType rust nmap <leader>m :!rustc % && ./%:r<cr>


"html expand
autocmd FileType html imap <leader>x <esc>f< i>
autocmd FileType html imap <leader>t {%  %}<Left><Left><Left>

augroup dtl_ft
  au!
  autocmd BufNewFile,BufRead *.dtl set syntax=html
  autocmd BufNewFile,BufRead *.dtl set filetype=html
augroup END
" COC stuff {{{
let g:coc_global_extensions = [
  \ 'coc-emoji', 'coc-prettier',
  \ 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin',
  \ 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml','coc-snippets','coc-highlight',
  \ 'coc-emmet','CppSnippets','coc-solargraph','coc-python','coc-html','coc-rls',
  \ 'https://github.com/one-harsh/vscode-cpp-snippets',
  \]
  " Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

nmap <leader>rn <Plug>(coc-rename)

" autocmd CursorHold * silent call CocActionAsync('highlight')
"hover info
nnoremap <leader>ho :call <SID>show_documentation()<CR>
"function {{{
"
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"}}}
"}}}


nmap <leader>c :Goyo 90x90<cr>

autocmd FileType python call SetPythonOptions()
function! SetPythonOptions()
    nmap <leader>db  obreakpoint(context=10)<esc>
    nmap <leader>pc o"""<cr><esc>O
    nmap <leader>mp :! mypy %<cr>
    nmap <leader>mm :! python3 %<cr>
    set nofoldenable
    set foldlevel=99
endfunction


autocmd BufEnter,BufNew,BufEnter *.cson call SetCSON()
function! SetCSON()
    set filetype=markdown
    IndentLinesDisable
endfunction

nmap <leader>dd <Plug>DashSearch
nmap <leader>wd 1<C-g>

let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0

nmap <leader>fix :ALEFix<cr>
nnoremap <leader>mv :tab split<CR>


autocmd BufNewFile,BufRead .env* set filetype=sh
