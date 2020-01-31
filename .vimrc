" vim:fdm=marker
" vim: set foldlevel=0:

let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python'
"
"TODO
"fix oh my zsh
"fix keep jumps normal
"startify settings
"python tools
"rainbow syntax
"script to install lang servers
"add rougify gem script
"add rust devicon-lookup
"add rust bat
"add prettier

"Install plugin manager if it doesnt exist {{{
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}
"Plugins {{{
call plug#begin()

" Plug 'klen/rope-vim'
">>> UI
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
        "config {{{
        nmap <leader>nt :NERDTreeToggle<cr>
        let NERDTreeMapOpenSplit='s'
        let NERDTreeMapActivateNode='l'
        let NERDTreeMapOpenVSplit='v'
        nmap <Leader>r :NERDTreeRefreshRoot<cr>
        "}}}
    Plug 'mhinz/vim-startify'
    "disabled {{{
    "Plug 'mhinz/vim-grepper'
    "}}}

">>> syntax and autofill
    Plug 'dense-analysis/ale'
        "config :TODO fix linting situation {{{
        nmap <leader>fd :let b:ale_fix_on_save = 0<cr>
        nmap <leader>fe :let b:ale_fix_on_save = 1<cr>
        nmap <leader>tl :ALEToggle<cr>| "Toggle ALE linting
        nmap <leader>fix :ALEFix<cr>
        let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'javascript': ['eslint','prettier'],
        \   'python': ['autopep8'],
        \   'ruby': ['standardrb']
        \   }
        let g:ale_linters = {
        \   'ruby': ['standardrb'],
        \   'python': ['flake8', 'mypy', 'pylint', 'pyls'],
        \   'rust': ['cargo', 'rls'],
        \   }
        let g:ale_completion_enabled = 0
        let g:ale_fix_on_save = 1
        nmap <leader>dn :ALEGoToDefinition<cr>zz
        nmap <leader>dt :tab split<cr> :ALEGoToDefinition<cr>zz
        nmap <leader>ds :split<cr> :ALEGoToDefinition<cr>zz
        nmap <leader>dv :vsplit<cr> :ALEGoToDefinition<cr>zz
		nnoremap <leader>doc :ALEHover<CR>
        "}}}
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
        "config {{{
		nnoremap <leader>ho :call <SID>show_documentation()<CR>
        let g:coc_global_extensions = [
          \ 'coc-emoji', 'coc-prettier',
          \ 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin',
          \ 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml','coc-snippets','coc-highlight',
          \ 'coc-emmet','CppSnippets','coc-solargraph','coc-python','coc-html','coc-rls',
          \ 'https://github.com/one-harsh/vscode-cpp-snippets',
          \]
        " }}}
    Plug 'frazrepo/vim-rainbow'
        "config {{{
        let g:rainbow_active = 1
        " }}}
    Plug 'sheerun/vim-polyglot'
        "config {{{
        " let g:polyglot_disabled = ['python-indent']
        "}}}
    "disabled {{{
    "Plug 'vim-python/python-syntax'
    "Plug 'Nader-gator/vim-polyglot'
    "Plug 'andymass/vim-matchup'
    "}}}

">>> Themses and visual
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'
        "config {{{
        "WindowNumber (for airline) {{{
        function! WindowNumber(...)
            let builder = a:1
            let context = a:2
            call builder.add_section('airline_c', '%{tabpagewinnr(tabpagenr())}')
            return 0
        endfunction
        "}}}
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#show_tab_nr = 1
        let g:airline#extensions#tabline#formatter = 'unique_tail'
        let g:airline#extensions#branch#enabled = 1
        let g:airline#extensions#hunks#enabled = 1
        let g:airline_section_b = '%{strftime("%H:%M")}'
    "}}}
    Plug 'Yggdroot/indentLine' "adds lines in indents
        "config {{{
        let g:indentLine_char_list = ['│']
        let g:indentLine_leadingSpaceEnabled = 1
        let g:indentLine_leadingSpaceChar = '·'
        let g:indentLine_fileTypeExclude = ['markdown','nerdtree']
        autocmd FileType nerdtree IndentLinesDisable
        "}}}
    Plug 'junegunn/goyo.vim'
        "config {{{
        nmap <leader>goy :Goyo 90x90<cr>
        "}}}
    " Plug 'joshdick/onedark.vim'
    Plug 'morhetz/gruvbox'
    Plug 'ryanoasis/vim-devicons' "MAYBE, 4 ms startup
    "disabled {{{
    "Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
    "Plug 'TaDaa/vimade'
    "}}}

">>> Motion and navigation
    Plug 'easymotion/vim-easymotion'
        "config {{{
        let g:EasyMotion_keys='edcrfvtgbyhnujm'
        map <C-q> <Plug>(easymotion-prefix)
        "}}}
    Plug 'wesQ3/vim-windowswap'
    "disabled {{{
    "Plug 'terryma/vim-multiple-cursors'
    "}}}

">>> ease of use
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
        "config {{{
        nmap <leader>fj :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND,0)<CR>
        nmap <leader>ff :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND,1)<CR>
        nmap <leader>git :call Fzf_git_diff_files_with_dev_icons()<CR>
        nmap <C-f> :Files<cr>|    "fuzzy find files in the working directory (where you launched Vim from)
        nmap <leader>fl :Lines<cr>|   "fuzzy find lines in the current file
        nmap <leader>fb :Buffers<cr>|  "fuzzy find an open buffer
        nmap <leader>ft :Tags<cr>|     "fuzzy find text in the working directory
        nmap <leader>fc :Commands<cr>| "fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)
        nmap <leader>fg :Ag<cr>
        let $FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'
        let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        let g:fzf_action = {
          \ 'ctrl-t': 'tab split',
          \ 'ctrl-s': 'split',
          \ 'ctrl-v': 'vsplit' }
        command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
        " let g:fzf_layout = { 'window': 'call FloatingFZF()' }
        "}}}
    Plug 'mattn/emmet-vim'
        "config {{{
        let g:user_emmet_leader_key=','
        let g:user_emmet_install_global = 0
        let g:user_emmet_mode='i'
        autocmd FileType html,css EmmetInstall
        "}}}
    Plug 'vimlab/split-term.vim'
        "config {{{
        nmap <leader>ts :Term<cr>
        nmap <leader>tv :VTerm<cr>
        nmap <leader>tt :TTerm<cr>
        "}}}
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
        "config {{{
        autocmd Filetype tex setl updatetime=1
        let g:livepreview_previewer = 'open -a Preview'
        nmap <leader>ltx :LLPStartPreview<cr>
        "}}}
    Plug 'junegunn/vim-easy-align'
        "config {{{
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
        "}}}
    Plug 'tomtom/tcomment_vim'
        "config {{{
        nmap <C-c> gcc
        "}}}
    Plug 'gu-fan/colorv.vim', {'on': 'ColorVEdit'}
        "config {{{
        nmap <leader>ec :ColorVEdit<cr>
        "}}}
    Plug 'FooSoft/vim-argwrap'
        "config {{{
        nnoremap <leader>aw :ArgWrap<CR>
        "}}}
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown'  }
        "config {{{
        let g:mkdp_auto_close = 0
        "}}}
    Plug 'tpope/vim-eunuch' "TODO: look up quickfix window for Cfind
    Plug 'tpope/vim-surround'
    "disabled {{{
    "Plug 'jeetsukumaran/vim-pythonsense' TODO: find replacement
    "Plug 'brooth/far.vim' TODO: find replacement
    "Plug 'vim-scripts/LineJuggler' | Plug 'inkarkat/vim-ingo-library'
    "Plug 'scrooloose/nerdcommenter'
    "Plug 'vim-scripts/greplace.vim'
    "}}}

">>> invisible help
    Plug 'ianding1/leetcode.vim'
        "config {{{
        let g:leetcode_solution_filetype='python'
        let g:leetcode_username='nader-gator'
        "}}}
    Plug 'editorconfig/editorconfig-vim'
        "config {{{
        let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
        "}}}
    Plug 'rizzatti/dash.vim'
        "config {{{
        nmap <leader>dd <Plug>DashSearch
        "}}}
    Plug 'cohama/lexima.vim' "auto close brackets TODO: figure some stuff out
        "config {{{
        nmap <leader>pt :let b:lexima_disabled = get(b:, 'lexima_disabled', 1)<cr>
        "}}}
    Plug 'alvan/vim-closetag' "auto close html tags with >>
    Plug 'tmhedberg/SimpylFold' "folding for python
    Plug 'Konfekt/FastFold'
    Plug 'tpope/vim-repeat'
    "disabled {{{
    "Plug 'tpope/vim-sensible'
    "Plug 'ryvnf/readline.vim'
    "}}}

">>> Git
    Plug 'airblade/vim-gitgutter'
        "config {{{
        nmap <leader>ggt :GitGutterToggle<cr>
        nmap <Leader>gd <Plug>(GitGutterPreviewHunk)
        nmap <Leader>gu <Plug>(GitGutterUndoHunk)
        let g:gitgutter_preview_win_floating = 0
        " let g:gitgutter_enabled = 0
        "}}}
    "disabled {{{
    "Plug 'tpope/vim-fugitive'
    "}}}

call plug#end()
"post plug commands {{{
    "vim-airline/vim-airline {{{
    call airline#add_statusline_func('WindowNumber')
    call airline#add_inactive_statusline_func('WindowNumber')
    "}}}
"}}}
"}}}
"basic config {{{
set re=1
set lazyredraw
set guioptions=M
set splitbelow
set splitright
set mouse=a
set fileignorecase
set wildignorecase
syntax on
" colorscheme onedark
colorscheme gruvbox
highlight CursorLineNr guifg=#e28409
set colorcolumn=100
set updatetime=300 | "gut gutter wants 400 coc wants 300
set shortmess+=c | "don't give |ins-completion-menu| messages. (coc)
set signcolumn=yes| "always show signcolumns (coc)
set ignorecase
set number relativenumber
"tabs
    filetype plugin indent on
    set expandtab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
"}}}
"sensible stuff {{{
filetype plugin indent on
set modeline
set foldmethod=syntax
set foldlevel=99
set display+=lastline
set autoindent
set backspace=start,eol ",indent
set complete-=i "C- P and N
set nrformats-=octal "inc num C-a, decrease C-x
set ttimeout
set ttimeoutlen=100
set incsearch
set synmaxcol=500
set laststatus=2
set ruler
set wildmenu
set scrolloff=1
"}}}
"key mappings {{{
    "simple maps {{{
    nnoremap <leader>v :e ~/.vimrc<cr>
    nnoremap <leader>sv :source $MYVIMRC<cr>
    nmap <BS> \
    map <BS><BS> \\
    nnoremap * m`:keepjumps normal! *``<cr>
    nnoremap <Space> :noh<cr>
    nmap <leader>tn :tabnew<cr>
    nmap Q :q<cr>
    nmap ]w :w<cr>
    nmap <leader>wd 1<C-g>
    nnoremap <leader>mv :tab split<CR>
    nnoremap <expr> <leader>fa &foldlevel ? 'zM' :'zR'
    "window navigation {{{
        nnoremap <C-h> <C-w>h
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l
    "}}}
    "copy/pasting/pasting {{{
        "deleting pasting
        nnoremap d "ad
        vnoremap d "ad
        nnoremap dd "add
        nnoremap <leader>pp "ap
        "Copy to clipboard
        vnoremap  y  "+y
        nnoremap  Y  "+yg_
        nnoremap  y  "+y
        nnoremap  yy  "+yy
        "Paste from clipboard
        nnoremap p "+p
        nnoremap P "+P
        vnoremap p "+p
        vnoremap P "+P
    "}}}
    "floating menu nav {{{
        inoremap <expr> <C-j> pumvisible() ? "\<C-n>": "\<C-j>"
        inoremap <expr> <C-k> pumvisible() ? "\<C-p>": "\<C-k>"
    "}}}
    "}}}
    "function calls {{{
    nnoremap <leader>zz :call VCenterCursor()<CR>
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
    "}}}
"}}}
"language specific mapping {{{
    "C{{{
    autocmd FileType c call SetClang()
    function! SetClang()
        nmap <leader>mm :w \|!gcc % && ./a.out<cr>
    endfunction
    "}}}
    "C++{{{
    autocmd FileType cpp call SetCpplang()
    function! SetCpplang()
        nmap <leader>mm :w \|!g++ % && ./a.out<cr>
    endfunction
    "
    "}}}
    "Rust{{{
    autocmd FileType rust call SetRustlang()
    function! SetRustlang()
        nmap <leader>mm :w \|!rustc % && %:r<cr>
    endfunction
    "
    "}}}
    "Haskell{{{
    autocmd FileType haskell call SetHaskelllang()
    function! SetHaskelllang()
        nmap <leader>mm :w \|!ghc % && ./%:r<cr>
    endfunction
    "
    "}}}
    "Python{{{
    autocmd FileType python call SetPythonOptions()
    function! SetPythonOptions()
        nmap <leader>db  obreakpoint(context=10)<esc>
        nmap <leader>pc o"""<cr><esc>O
        nmap <leader>mp :w \|! mypy %<cr>
        nmap <leader>mm :w \|! python3 %<cr>
        set nofoldenable
        set foldlevel=99
    endfunction
    "}}}
    "HTML{{{
    autocmd FileType html call SetHTML()
    function! SetHTML()
        imap <leader>x <esc>f< i>
        imap <leader>t {%  %}<Left><Left><Left>
        call rainbow#clear()
    endfunction
    "}}}
    "dtl {{{
      autocmd BufNew,BufRead *.dtl call Setdtl()
      function! Setdtl()
        set syntax=html
        set filetype=html
        call rainbow#clear()
      endfunction
    "}}}
    "Sass {{{
      autocmd BufNew,BufRead *.scss call SetSass()
      function! SetSass()
        call rainbow#clear()
      endfunction
    "}}}
    "CSON {{{
    autocmd BufNew,Bufread *.cson call SetCSON()
    function! SetCSON()
        set filetype=markdown
        IndentLinesDisable
    endfunction
    "}}}
    ".env files{{{
    autocmd BufNew,BufRead .env* set filetype=sh
    "}}}
"}}}
"autocommands {{{
augroup numbertoggle
autocmd!
let ftToIgnore = ['nerdtree', 'startify']
autocmd BufEnter,FocusGained,InsertLeave * if index(ftToIgnore,&ft) < 0|:set relativenumber
autocmd BufLeave,FocusLost,InsertEnter * if index(ftToIgnore,&ft) < 0|:set norelativenumber
augroup END
au BufReadPost *.html set filetype=html
"}}}
"iterative mapping {{{
let i = 1
while i <= 20
    execute 'nnoremap <Leader>' . i . '<Space>' . ' :' . i . 'wincmd w<CR>'
    execute 'nnoremap ]' . i . '<Space> ' .  i . 'gt'
    execute 'nmap <Leader>di' . i . '<Space>' .
                \ ' :let buffno=bufnr("%")<cr>' .
                \ ':let linepos=line(".")<cr>:let colpos=col(".")<cr> :' . i .
                \ 'wincmd w<cr>:execute("buffer ".buffno)<cr>:call cursor(linepos,colpos)<cr>' .
                \ ' :ALEGoToDefinition<cr>zz'
    let i = i + 1
endwhile
"}}}
"commands {{{
command! -bang -bar -nargs=? -complete=file E :call s:MKDir(<f-args>) | e<bang> <args>
"}}}
"gui related configs {{{
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
"}}}
"function definitions {{{
"FZF optiona and DEVICON function {{{
"normal search {{{
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
"}}}
"git diff {{{
 function! Fzf_git_diff_files_with_dev_icons()
  let l:fzf_files_options = '--ansi --preview "sh -c \"(git diff --color=always -- {3..} | sed 1,4d; bat --color always --style numbers {3..}) | head -'.&lines.'\""'
   function! s:edit_devicon_prepended_file_diff(item)
    "echom a:item
    let l:file_path = a:item[7:-1]
    "echom l:file_path
    let l:first_diff_line_number = system("git diff -U0 ".l:file_path." | rg '^@@.*\+' -o | rg '[0-9]+' -o | head -1")
    execute 'silent e' l:file_path
    execute l:first_diff_line_number
  endfunction
   call fzf#run({
        \ 'source': 'git -c color.status=always status --short --untracked-files=all | devicon-lookup',
        \ 'sink':   function('s:edit_devicon_prepended_file_diff'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction
"}}}
"}}}
"VCenterCursor {{{
if !exists('*VCenterCursor')
  augroup VCenterCursor
  au!
  au OptionSet *,*.*
    \ if and( expand("<amatch>")=='scrolloff' ,
    \         exists('#VCenterCursor#WinEnter,WinNew,VimResized') )|
    \   au! VCenterCursor WinEnter,WinNew,VimResized|
    \ endif
  augroup END
  function VCenterCursor()
    if !exists('#VCenterCursor#WinEnter,WinNew,VimResized')
      let s:default_scrolloff=&scrolloff
      let &scrolloff=winheight(win_getid())/2
      au VCenterCursor WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
    else
      au! VCenterCursor WinEnter,WinNew,VimResized
      let &scrolloff=s:default_scrolloff
    endif
  endfunction
endif
"}}}
"MKDir {{{
function! s:MKDir(...)
    if         !a:0
           \|| isdirectory(a:1)
           \|| filereadable(a:1)
           \|| isdirectory(fnamemodify(a:1, ':p:h'))
        return
    endif
    return mkdir(fnamemodify(a:1, ':p:h'), 'p')
endfunction
"}}}
"ExecuteMacroOverVisualRange {{{
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
"}}}
"show_documentation {{{
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"}}}
"}}}
