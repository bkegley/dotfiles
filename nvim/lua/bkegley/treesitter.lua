local parsers = require'nvim-treesitter.parsers'
local configs = require'nvim-treesitter.configs'

configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "c", "rust" },
  },
  playground = {
    enable = true,
    updatetime = 25
  }
}

local parser_configs = parsers.get_parser_configs()
parser_configs.html.used_by = 'svelte'
