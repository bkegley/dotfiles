"==============================================================
" Vim Cofiguration
"==============================================================

call plug#begin('~/.vim/plugged')

"Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/diagnostic-nvim'

if has('nvim-0.5')
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/telescope.nvim'
else
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
endif
Plug 'jremmen/vim-ripgrep'
Plug 'airblade/vim-rooter'
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'

" js/ts
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'preservim/nerdcommenter'

" c#
Plug 'Omnisharp/omnisharp-vim'

" Rust
Plug 'rust-lang/rust.vim'

" aesthetics
Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'relastle/bluewery'
Plug 'jaredgorski/fogbell.vim'
Plug 'carstenkj02/dosbox-vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'christianchiarulli/nvcode-color-schemes.vim'

let g:tokyonight_style = 'storm'

" additional plugins
"Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}

call plug#end()


set noerrorbells
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set hidden
set completeopt=menuone,noinsert,noselect
set shortmess+=c

let mapleader = " "

nnoremap <leader>rc :vsp ~/.config/nvim/init.vim<CR>
nnoremap <leader><CR> :source ~/.config/nvim/init.vim<CR>

" remove arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

inoremap jk <ESC>
inoremap JK <ESC>
inoremap jK <ESC>
vnoremap jk <ESC>
vnoremap JK <ESC>
vnoremap jK <ESC>

" Theming/Styling
"==============================================================

syntax on

set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set number
set relativenumber
set nowrap
set noshowmode

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme OceanicNext
let g:airline_theme='oceanicnext'

if (has("termguicolors"))
  set termguicolors
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
"



" LSP
" ========

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gt   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>af <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <silent> gw    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" tab navigate completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


let g:completion_matching_strategy_list = ['substring', 'exact', 'fuzzy', 'all']
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1
let g:completion_chain_complete_list = [
  \{'complete_items': ['lsp', 'snippet']},
  \{'mode': '<c-p>'},
  \{'mode': '<c-n>'},
\]
"
"nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Use <c-space> to trigger completion.
"if has('nvim')
  "inoremap <silent><expr> <c-space> coc#refresh()
"else
  "inoremap <silent><expr> <c-@> coc#refresh()
"endif
"

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction

set statusline+=\ %{LspStatus()}

"
" Project Navigation 
"==============================================================

if has('nvim-0.5')
  nnoremap <C-p> :lua FindFiles()<CR>
  nnoremap <leader>ps :lua LiveGrep()<CR>
  nnoremap <leader>pw :lua GrepString(vim.fn.expand("<cword>"))<CR>
  nnoremap <leader>ls :lua Buffers()<CR>
  nnoremap <leader>dot :lua Dotfiles()<CR>
else
  let $FZF_DEFAULT_OPTS='--reverse'
  let g:fzf_layout = { 'window': {'width': 0.8, 'height': 0.8} }
  " set fzf to respect .gitignore
  let $FZF_DEFAULT_COMMAND='rg --files'
  nnoremap <C-p> :Files<CR>


  " project search/replace
  nnoremap <leader>ps :Rg<SPACE>
  nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
endif


map <leader><leader> :b#<CR>


let g:NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"
nnoremap <leader>ne :NERDTreeToggle<CR>

" Window Navigation 
"==============================================================

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>


" Misc 
"==============================================================

autocmd BufWritePre *.cs :OmniSharpCodeFormat
autocmd BufWritePre *js,*ts,*jsx,*tsx,*.graphql,*.json,*.md,*.mdx :Prettier
let g:rustfmt_autosave = 1

nmap <leader>g :Git<SPACE>

let g:Omnisharp_server_stdio = 0

lua require 'bkegley'
