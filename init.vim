set tabstop=2
set shiftwidth=2
set expandtab
syntax on
set autoindent
set cindent
let &t_Co=256
set termencoding=utf-8
set encoding=utf-8
set termguicolors
set hidden
set number
set termguicolors
set directory^=$HOME/swap
autocmd FileType make setlocal noexpandtab
filetype plugin indent on

" =============================================================================
" Plugins
" =============================================================================
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'rgrinberg/vim-ocaml'
Plug 'w0rp/ale'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
Plug 'mileszs/ack.vim'
Plug 'majutsushi/tagbar'
Plug 'kshenoy/vim-signature' " nice management of marks
Plug 'airblade/vim-rooter'
Plug 'xianzhon/vim-code-runner'
Plug 'inside/vim-search-pulse'
Plug 'asciidoc/vim-asciidoc'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'fixdpt/neosnippet-snippets'
call plug#end()

let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}

" =============================================================================
" Key Mappings
" =============================================================================
let mapleader = ";"
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>l :ALEDetail<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>t :TagbarOpenAutoClose<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>a :Ack<Space>-w<Space><cword><CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR> 

"hi CursorLine cterm=None ctermbg=DarkRed ctermfg=white guibg=DarkRed guifg=white
"hi CursorLine cterm=underline ctermbg=DarkRed ctermfg=white 
hi CursorLine ctermbg=Gray ctermfg=white 
set cursorline
"highlight clear CursorLine

" Completion (YCM)
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt-=preview
let g:ycm_python_binary_path = '/usr/local/bin/python3'

" ALE
let g:ale_fixers = {
\   'java': ['google_java_format'],
\   'c': ['clang-format'],
\   'h': ['clang-format'],
\   'c++': ['clang-format'],
\   'cpp': ['clang-format'],
\   'scala': ['scalafmt'],
\   'ocaml': ['ocamlformat'],
\   'haskell': ['brittany'],
\   'python': ['isort', 'black'],
\   'json': ['prettier'],
\}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='base16_atelierdune'
" to stop pep8 based linters from complaining as black uses 88 as line length
let g:ale_python_black_options = '-l 79'
set background=dark

if executable('ag')
  " w = match whole words
  let g:ackprg = "ag -w --ignore='*Test*.java' --ignore='*.sql' --ignore='*.htm*' --ignore='*.xml' --vimgrep"
endif

let g:pandoc#modules#disabled = ["folding"]

let g:rustfmt_autosave = 1

" Make airline less cluttered.
let g:airline_section_b='' " vcs info
let g:airline_section_x='' " filetype
let g:airline_section_z='%{line("$")} : %{col(".")}'
" the below denote warnings etc that linters flag. 
let g:airline_section_error='' 
let g:airline_section_warning=''

" make the gutter same colour as lines
highlight clear SignColumn

let g:rooter_patterns = ['makefile', 'Rakefile', 'gradlew', '.git/']

" \ 'haskell' : 'stack run',
let g:CodeRunnerCommandMap = {
      \ 'java' : 'javac -Xlint:all $fileName && java -ea $fileNameWithoutExt',
      \ 'rust' : 'rustc $fileName && ./$fileNameWithoutExt',
      \ 'cpp' : 'clang++ -std=c++11 $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt',
      \ 'python' : 'python3 $fileName',
      \ 'ocaml' : 'ocaml $fileName',
      \ 'haskell' : 'ghc $fileName && ./$fileNameWithoutExt',
      \}
let g:code_runner_output_window_size=10

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" expand snippet on tab
imap <expr><TAB>
	 \ neosnippet#expandable_or_jumpable() ?
	 \    "\<Plug>(neosnippet_expand_or_jump)" :
         \ 	  pumvisible() ? "\<C-n>" : "\<TAB>"
