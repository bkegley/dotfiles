call plug#begin('~/.vim/plugged')
" this is a comment
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-rooter'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" js/ts
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'jaredgorski/fogbell.vim'

" c#
Plug 'Omnisharp/omnisharp-vim'

Plug 'mhartington/oceanic-next'
Plug 'relastle/bluewery'

call plug#end()

syntax on

set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set nu
set relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set hidden

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey
set background=dark
colorscheme OceanicNext
let g:airline_theme='oceanicnext'

let NERDTreeShowHidden=1
let mapleader = " "

inoremap jk <ESC>
vnoremap jk <ESC>
nnoremap <leader>rc :vsp ~/.config/nvim/init.vim<CR>
nnoremap <leader><CR> :source ~/.config/nvim/init.vim<CR>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
autocmd BufWritePre *js,*ts,*jsx,*tsx,*.graphql :Prettier
autocmd BufWritePre *.cs :OmniSharpCodeFormat

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <leader>ne :NERDTreeToggle<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nmap <leader>g :G<CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>rg :Rg<Space>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Terminal
nnoremap <leader>t :below new +term<CR> :resize 10<CR> i
tnoremap <ESC> <C-\><C-N>
tnoremap jk <C-\><C-N>

vnoremap <leader>fra y:%s/<C-r><C-r>"//g<Left><Left>
