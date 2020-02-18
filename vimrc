" allow for vundle to handle filetypes
set nocompatible

" setup vim-plug
call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/mru.vim'
Plug 'drmikehenry/vim-fontsize'
Plug 'arzg/vim-substrata'
Plug 'liuchengxu/vim-clap'

" Colors 
Plug 'arzg/vim-colors-xcode'
Plug 'rafi/awesome-vim-colorschemes' 
Plug 'endel/vim-github-colorscheme'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'

" Dev
Plug 'scrooloose/nerdtree'
Plug 'Shougo/unite.vim'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/vim-clang-format'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/FuzzyFinder'
Plug 'justinmk/vim-syntax-extra'

" lsp
Plug 'natebosch/vim-lsc'

call plug#end()

" misc visual stuff
set background=dark
" set termguicolors
" colorscheme base16-solarized-dark

set backspace=eol,start
set formatoptions=tcql
set visualbell
set sidescrolloff=0
set number
syntax on

" Help stuff
set helplang=en
set history=1500
set hlsearch
set ignorecase

"
" Disable swap files (I hate them, I HATE THEM!)
set nobackup       " no backup files
set nowritebackup  " only in case you don't want a backup file while editing
set noswapfile     " no swap files
set nowrap

" tabs
set expandtab
set tabstop=4
set shiftwidth=4
set incsearch

" status bar
set ls=2
set statusline=%F       " full file path
set statusline+=%m      " modified flag
set statusline+=%r      " read only flag
set statusline+=%{fugitive#statusline()} " git branch if any
set statusline+=(
set statusline+=%c,     " columns
set statusline+=[%l/%L] " column line/LINES
set statusline+=)
set equalalways

" do not exit visual mode after indenting
vnoremap < <gv 
vnoremap > >gv 

" setlocal spell spelllang=en_us
if &diff
    colorscheme github 
    setlocal spell spelllang=
endif

" Find files recursively
set path=$PWD/**

let mapleader = ","

" neocomplete <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" disable scratch window
set completeopt=menu,popup

" clang format
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>"
nmap <Leader>C :ClangFormatAutoToggle<CR>

autocmd FileType c,h,cpp setlocal omnifunc=lsp:complete

let g:lsp_async_completion=0
packadd termdebug

" Register ccls C++ lanuage server.
if executable('ccls')
    let g:lsc_server_commands = {
    \ 'cpp': {
    \    'command': 'ccls',
    \    'suppress_stderr' : v:true,
    \    'message_hooks': {
    \        'initialize': {
    \            'initializationOptions': {'cache': {'directory': '/tmp/ccls/cache'}},
    \            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
    \        },
    \    },
    \  },
    \}
endif
let g:lsc_enable_autocomplete = v:true
let g:lsc_auto_map = v:true
let g:lsc_reference_highlights = v:false 

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()
let g:lsp_fold_enabled = 0

" Termdebug
let g:termdebug_wide=1
noremap <F12> :vertical resize +5<CR>
noremap <F11> :vertical resize -5<CR> 
noremap <F9> :Termdebug dist/bin/nuodb<CR>
noremap <F5> :Step<CR>
noremap <F6> :Over<CR>
noremap <C-b> :Break<CR>
noremap <F8> :make -j 8 dist<CR>

" ccls key bindings
noremap <Leader>gD :tab LSClientGoToDefinitionSplit<cr>
noremap <Leader>gd :LSClientGoToDefinition<cr>
noremap <Leader>gj :LspDeclaration<cr>
noremap <Leader>gf :LSClientFindReferences<cr>
noremap <Leader>gI :LSClientFindImplementations<cr>
noremap <Leader>gh :LSClientSignatureHelp<cr>
noremap <Leader>gs :LSClientWorkspaceSymbol<cr>

" Clap shortcuts
noremap <F3> :Clap files<CR>
