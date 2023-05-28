return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        build = ":MasonUpdate",
        config = true
      },
      'williamboman/mason-lspconfig.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {}
      },
      'folke/neodev.nvim',
    },
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'bkegley.format'
    end
  }
}
