local map = vim.keymap.set

-- Escape
map("i", "jk", "<ESC>")
map("i", "JK", "<ESC>")
map("i", "jK", "<ESC>")
map("v", "jk", "<ESC>")
map("v", "JK", "<ESC>")
map("v", "jK", "<ESC>")
map("t", "jk", "<C-\\><C-n>")

-- Disable arrow keys
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

-- Window navigation
map("n", "<leader>h", "<cmd>wincmd h<CR>")
map("n", "<leader>j", "<cmd>wincmd j<CR>")
map("n", "<leader>k", "<cmd>wincmd k<CR>")
map("n", "<leader>l", "<cmd>wincmd l<CR>")
map("n", "<leader>+", "<cmd>vertical resize +5<CR>")
map("n", "<leader>-", "<cmd>vertical resize -5<CR>")

-- Buffers
map("n", "<leader><leader>", "<cmd>b#<CR>")
map("n", "<leader>bd", "<cmd>%bd|e#<CR>")

-- Diagnostics
map("n", "<leader>dn", vim.diagnostic.goto_next)
map("n", "<leader>dp", vim.diagnostic.goto_prev)
map("n", "<leader>ds", vim.diagnostic.open_float)

-- LSP (attached via on_attach in lsp.lua, but definition/declaration are universal)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gt", vim.lsp.buf.type_definition)
map("n", "K", vim.lsp.buf.hover)
map("n", "<C-k>", vim.lsp.buf.signature_help)
map("n", "<leader>af", vim.lsp.buf.code_action)
map("n", "<leader>rn", vim.lsp.buf.rename)
