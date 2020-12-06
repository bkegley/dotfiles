--------------------------------------------------------------
-- Vim Cofiguration
--------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.syntax = 'on'
vim.g.colorscheme = 'gloombuddy'

local o = vim.o
local bo = vim.bo
local wo = vim.wo

--syntax on
o.errorbells = false
o.smartcase = true
o.showmode = false
bo.swapfile = false
--o.backup = false --default
--o.undodir = '~/.config/nvim/undodir' --default
bo.undofile = true
--o.incsearch = true --default
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
wo.relativenumber = true
--set shortmess+=c
bo.autoindent = true
bo.smartindent = true

bo.tabstop = 2
bo.softtabstop = 2
bo.shiftwidth = 2
bo.expandtab = true
wo.number = true -- display line numbers
wo.relativenumber = true -- display relative line numbers
wo.wrap = false

require'bkegley'

