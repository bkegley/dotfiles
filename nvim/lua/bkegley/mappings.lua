local vim = vim
local utils = require'bkegley.utils'

local setup_mappings = function()
  -- Temp commands
  vim.cmd[[autocmd BufWritePre *.cs :lua vim.lsp.buf.formatting_sync()]]
  vim.cmd[[autocmd BufWritePre *js,*ts,*jsx,*tsx,*.graphql,*.json,*.md,*.mdx,*.svelte,*.yml,*yaml :Prettier]]

  utils.key_mapper('n', '<leader><C-W>', ':write | edit | TSBufEnable highlight<CR><CR>')
  -- Completion
  vim.cmd[[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]]
  vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
  vim.cmd[[inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"]]

  -- Diagnostics
  utils.key_mapper('n', '<leader>dn', ':lua vim.lsp.diagnostic.goto_next()<CR>')
  utils.key_mapper('n', '<leader>dp', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
  utils.key_mapper('n', '<leader>ds', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')

  -- LSP
  utils.key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
  utils.key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
  utils.key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
  utils.key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
  utils.key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
  utils.key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
  utils.key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
  utils.key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
  utils.key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
  utils.key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
  utils.key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

  -- Telescope
  utils.key_mapper('n', '<C-p>', ':lua require"bkegley.telescope".find_files()<CR>')
  utils.key_mapper('n', '<leader>fs', ':lua require"bkegley.telescope".live_grep()<CR>')
  utils.key_mapper('n', '<leader>fw', ':lua require"bkegley.telescope".grep_string(vim.fn.expand("<cword>"))<CR>')
  utils.key_mapper('n', '<leader>fh', ':lua require"bkegley.telescope".help_tags()<CR>')
  utils.key_mapper('n', '<leader>fb', ':lua require"bkegley.telescope".buffers()<CR>')
  utils.key_mapper('n', '<leader>f/', ':lua require"bkegley.telescope".search_history()<CR>')
  utils.key_mapper('n', '<leader>fq', ':lua require"bkegley.telescope".quickfix()<CR>')

  utils.key_mapper('n', '<leader>frs', ':lua require"bkegley.telescope".relative_grep()<CR>')

  utils.key_mapper('n', '<leader>gb', ':lua require"bkegley.telescope".git_branches()<CR>')
  utils.key_mapper('n', '<leader>gc', ':lua require"bkegley.telescope".git_commits()<CR>')
  utils.key_mapper('n', '<leader>gbc', ':lua require"bkegley.telescope".git_buffer_commits()<CR>')
  utils.key_mapper('n', '<leader>gs', ':lua require"bkegley.telescope".git_status()<CR>')

  utils.key_mapper('n', '<leader>fd', ':lua require"bkegley.telescope".dotfiles()<CR>')


  -- Nerdtree
  utils.key_mapper('n', '<leader>ne', ':NERDTreeToggle<CR>')

  -- Navigation
  utils.key_mapper('n', '<leader>h', ':wincmd h<CR>')
  utils.key_mapper('n', '<leader>j', ':wincmd j<CR>')
  utils.key_mapper('n', '<leader>k', ':wincmd k<CR>')
  utils.key_mapper('n', '<leader>l', ':wincmd l<CR>')
  utils.key_mapper('n', '<leader>+', ':vertical resize +5<CR>')
  utils.key_mapper('n', '<leader>-', ':vertical resize -5<CR>')

  -- Highlights
  utils.key_mapper('', '<leader>hi', ':echo ' ..
    '"hi<" . synIDattr(synID(line("."),col("."),1),"name") . "> trans<"' ..
    '. synIDattr(synID(line("."),col("."),0),"name") ' ..
    '. "> lo<". synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>'
  )

  utils.key_mapper('', '<leader>hhi', ':TSHighlightCapturesUnderCursor<CR>')

  -- Misc
  utils.key_mapper('', '<up>', '<nop>')
  utils.key_mapper('', '<down>', '<nop>')
  utils.key_mapper('', '<left>', '<nop>')
  utils.key_mapper('', '<right>', '<nop>')
  utils.key_mapper('i', 'jk', '<ESC>')
  utils.key_mapper('i', 'JK', '<ESC>')
  utils.key_mapper('i', 'jK', '<ESC>')
  utils.key_mapper('v', 'jk', '<ESC>')
  utils.key_mapper('v', 'JK', '<ESC>')
  utils.key_mapper('v', 'jK', '<ESC>')
  utils.key_mapper('t', 'jk', '<c-/><c-n>')
  utils.key_mapper('n', '<leader>bd', ':%bd|e#<CR>')

  utils.key_mapper('n', '<leader>bd', ':%bd|e#<CR>')
  utils.key_mapper('n', '<leader><leader>', ':b#<CR>')
  utils.key_mapper('n', '<leader>asdf', ':lua ReloadConfig()<CR>')
end

setup_mappings()
