return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      animate = {
        enabled = false,
      },
      options = {
        left = { size = 30 },
        bottom = { size = 10 },
        right = { size = .35 },
        top = { size = 10 },
      },
      top = {
        {
          ft = "help",
          size = { height = .75 },
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
      },
    },
  },
  {
    'preservim/nerdtree',
    dependencies = {
      "folke/edgy.nvim",
      opts = {
        right = {
          {
            title = "NerdTree",
            ft = "nerdtree",
            size = { height = 0.35 },
          },
        }
      },
    }
  },
  'jiangmiao/auto-pairs',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  'preservim/nerdcommenter',
  'mhartington/oceanic-next',
  'relastle/bluewery',
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = {
          auto_trigger = true
        }
      })
    end
  },
}
