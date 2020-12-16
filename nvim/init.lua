--------------------------------------------------------------
local vim = vim

vim.g.mapleader = ' '
vim.g.colors_name = 'gloombuddy'

local o = vim.o
local bo = vim.bo
local wo = vim.wo

o.termguicolors = true
o.syntax = 'on'
o.errorbells = false
o.smartcase = true
o.showmode = false
bo.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
bo.autoindent = true
bo.smartindent = true

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
wo.number = true -- display line numbers
wo.relativenumber = true -- display relative line numbers
wo.signcolumn = 'yes'
wo.wrap = false


vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinPos = "right"

vim.g.Omnisharp_server_stdio = 0

require'bkegley'
