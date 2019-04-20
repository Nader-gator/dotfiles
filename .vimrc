call plug#begin()
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
call plug#end()

" color theme
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
syntax on
colorscheme onedark

"line number
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"___1___Fuzzy finder
nmap <leader>ff :Files<cr>|    " fuzzy find files in the working directory (where you launched Vim from)
nmap <leader>fl :BLines<cr>|   " fuzzy find lines in the current file
nmap <leader>fb :Buffers<cr>|  " fuzzy find an open buffer
nmap <leader>fr :Rg|           " fuzzy find text in the working directory
nmap <leader>fc :Commands<cr>| " fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)

"___2___ ALE
"TODO: lightline
"goto definition
nmap <leader>gdn :ALEGoToDefinition<cr>|          " Open the definition of the symbol under the cursor.
nmap <leader>gdt :ALEGoToDefinitionInTab<cr>|    " The same, but for opening the file in a new tab.
nmap <leader>gdh :ALEGoToDefinitionInSplit<cr>|  " The same, but in a new split.
nmap <leader>gdv :ALEGoToDefinitionInVSplit<cr>| " The same, but in a new vertical split.
"hover info
nmap <leader>hov :ALEHover<cr>| " The same, but in a new vertical split.
"toggle linting
nmap <leader>tl :ALEToggle<cr>| " Toggle ALE linting

"___3___Commenter
nmap <C-c> <Plug>NERDCommenterToggle

"___4___NERDtree
nmap \tt :NERDTreeToggle<cr>