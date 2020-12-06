local utils = require'bkegley.utils'

local setup_mappings = function()

  -- Diagnostics
  utils.key_mapper('n', '<leader>dn', ':lua vim.lsp.diagnostic.goto_next()<CR>')
  utils.key_mapper('n', '<leader>dp', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
  utils.key_mapper('n', '<leader>ds', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')

  -- Telescope
  utils.key_mapper('n', '<C-p>', ':lua FindFiles()<CR>')
  utils.key_mapper('n', '<leader>fs', ':lua LiveGrep()<CR>')
  utils.key_mapper('n', '<leader>fw', ':lua GrepString(vim.fn.expand("<cword>"))<CR>')
  utils.key_mapper('n', '<leader>fh', ':lua HelpTags()<CR>')
  utils.key_mapper('n', '<leader>fb', ':lua Buffers()<CR>')
  utils.key_mapper('n', '<leader>fd', ':lua Dotfiles()<CR>')

  -- Misc
  utils.key_mapper('n', '<leader>bd', ':%bd|e#<CR>')
  utils.key_mapper('n', '<leader>asdf', ':lua ReloadConfig()<CR>')
end

setup_mappings()
