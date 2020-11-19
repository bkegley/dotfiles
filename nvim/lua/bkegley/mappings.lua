local utils = require'bkegley.utils'

local setup_mappings = function()
  utils.key_mapper('n', '<leader>bd', ':%bd|e#<CR>')
  utils.key_mapper('n', '<leader>asdf', ':lua ReloadConfig()<CR>')
end

setup_mappings()
