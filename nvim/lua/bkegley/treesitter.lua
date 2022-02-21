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

parsers.html = 'svelte'
