local parsers = require'nvim-treesitter.parsers'
local configs = require'nvim-treesitter.configs'

configs.setup {
  ensure_installed = {
    'bash',
    'c_sharp',
    'comment',
    'css',
    'dockerfile',
    'dot',
    'graphql',
    'help',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'make',
    'markdown',
    'regex',
    'scss',
    'svelte',
    'todotxt',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
  },
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
