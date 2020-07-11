"==============================================================
" Vim Cofiguration
"==============================================================

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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

" c#
Plug 'Omnisharp/omnisharp-vim'

" aesthetics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'relastle/bluewery'
Plug 'jaredgorski/fogbell.vim'

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

let mapleader = " "

nnoremap <leader>rc :vsp ~/.config/nvim/init.vim<CR>
nnoremap <leader><CR> :source ~/.config/nvim/init.vim<CR>

" remove arrow keys
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

inoremap jk <ESC>
inoremap JK <ESC>
vnoremap jk <ESC>
vnoremap JK <ESC>


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
set termguicolors

set background=dark
colorscheme OceanicNext
let g:airline_theme='oceanicnext'


" Project Navigation 
"==============================================================

" set fzf to respect .gitignore
let $FZF_DEFAULT_COMMAND='rg --files'
nnoremap <C-p> :Files<CR>

map <leader><leader> :b#<CR>

" project search/replace
nnoremap <leader>ps :Rg<SPACE>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

let NERDTreeShowHidden=1
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
autocmd BufWritePre *js,*ts,*jsx,*tsx,*.graphql :Prettier

nmap <leader>g :G<CR>

" tab navigate completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" integrated terminal
nnoremap <leader>t :below new +term<CR> :resize 10<CR> i
tnoremap <ESC> <C-\><C-N>
tnoremap jk <C-\><C-N>

" replace all occurences of selection
vnoremap <leader>ra y:%s/<C-r><C-r>"//g<Left><Left>
" find/replace in line selection
xnoremap <leader>ra :s//g<Left><Left>
