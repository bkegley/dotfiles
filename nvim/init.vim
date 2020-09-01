"==============================================================
" Vim Cofiguration
"==============================================================

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'relastle/bluewery'
Plug 'jaredgorski/fogbell.vim'

Plug 'carstenkj02/dosbox-vim'

" additional plugins
"Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}

" to consider
" Plug 'justinmk/vim-sneak'

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
set termguicolors

set background=dark
colorscheme OceanicNext
let g:airline_theme='oceanicnext'


" Project Navigation 
"==============================================================

if has('nvim-0.5')
  nnoremap <C-P> :lua require('telescope.builtin').git_files { shorten_path = true  }<CR>
else
  " set fzf to respect .gitignore
  let $FZF_DEFAULT_COMMAND='rg --files'
  nnoremap <C-p> :Files<CR>
endif

let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': {'width': 0.8, 'height': 0.8} }

map <leader><leader> :b#<CR>

" project search/replace
nnoremap <leader>ps :Rg<SPACE>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
autocmd BufWritePre *js,*ts,*jsx,*tsx,*.graphql,*.json,*.md,*.mdx :Prettier
let g:rustfmt_autosave = 1

nmap <leader>g :Git<SPACE>

" tab navigate completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" documentation hover
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
  execute 'h '.expand('<cword>')
else
  call CocAction('doHover')
endif
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" integrated terminal
nnoremap <leader>t :below new +term<CR> :resize 10<CR> i
tnoremap <ESC> <C-\><C-N>
tnoremap jk <C-\><C-N>

" replace all occurences of selection
vnoremap <leader>ra y:%s/<C-r><C-r>"//g<Left><Left>
" find/replace in line selection
xnoremap <leader>ra :s//g<Left><Left>

let g:Omnisharp_server_stdio = 0
