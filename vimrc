" allow for vundle to handle filetypes
set nocompatible

" setup vim-plug
call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/mru.vim'
Plug 'drmikehenry/vim-fontsize'
Plug 'liuchengxu/vim-clap'

" Colors 
Plug 'altercation/vim-colors-solarized'
Plug 'arzg/vim-colors-xcode'
Plug 'chriskempson/base16-vim'
Plug 'endel/vim-github-colorscheme'
Plug 'rafi/awesome-vim-colorschemes' 

" Dev
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/vim-clang-format'
Plug 'justinmk/vim-syntax-extra'
Plug 'natebosch/vim-lsc'

call plug#end()

" misc visual stuff
set background=dark

set backspace=eol,start
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

" Override leader to be ','
let mapleader = ","

" disable scratch window
set completeopt=menu,popup

" Clang format. Use ,cf in normal mode to format either the selection of the
" entire file.
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>"
nmap <Leader>C :ClangFormatAutoToggle<CR>

" set autocomplete for c, h, cpp files
autocmd FileType c,h,cpp setlocal omnifunc=lsp:complete

" Set this to 1 if your project is small enough. It might be a big performance
" issue otherwise
let g:lsp_async_completion=0

" Load the termdebug plugin which allows gdb debugging
packadd termdebug

" Register ccls C++ lanuage server. The compile_comands.json file must be in
" the current vim folder. The ccls database goes into /tmp/ccls/cache
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
" Disable highlights because it's buggy and highlights the wrong things
let g:lsc_reference_highlights = v:false 

" disable floding because it's slightly buggy
set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()
let g:lsp_fold_enabled = 0

" Termdebug helpers. Make the layout vertical and map some keys for stepping,
" breaking, etc
let g:termdebug_wide=1
noremap <F12> :vertical resize +5<CR>
noremap <F11> :vertical resize -5<CR> 
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

" Clap shortcuts. Press F3 to start searching
noremap <F3> :Clap files<CR>

function! StripString(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

" search in files. This method searches for a pattern in all h/cpp files
" in the current path
function SearchText()
  let curline = getline('.')
  call inputsave()
  let pattern = StripString(input('Enter text: '))
  call inputrestore()
  let cmd = "noautocmd vim \"".l:pattern."\" **/*.cpp **/*.h"
  exec l:cmd
  cwindow
endfunction

" search in files
noremap <F4> :call SearchText() <CR>
