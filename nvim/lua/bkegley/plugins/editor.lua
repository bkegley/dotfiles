return {
  -- unsure
  -- 'jose-elias-alvarez/nvim-lsp-ts-utils',
  -- 'onsails/lspkind-nvim',
  --
  -- 'jremmen/vim-ripgrep',
  -- 'airblade/vim-rooter',


  'preservim/nerdtree',
  -- 'mbbill/undotree',
  -- {
  -- 'pwntester/octo.nvim',
  -- config=function()
  -- require'octo'.setup()
  -- end,
  -- },
  'jiangmiao/auto-pairs',
  -- 'sheerun/vim-polyglot',
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

  -- js/ts
  -- 'leafgarland/typescript-vim',
  -- 'pangloss/vim-javascript',
  -- 'peitalin/vim-jsx-typescript',
  'preservim/nerdcommenter',

  -- rs
  -- 'rust-lang/rust.vim',

  -- 'tjdevries/colorbuddy.nvim',
  -- 'bkegley/gloombuddy',
  'mhartington/oceanic-next',
  'relastle/bluewery',
  -- 'jaredgorski/fogbell.vim',
  -- 'carstenkj02/dosbox-vim',
  -- 'ghifarit53/tokyonight-vim',
  -- 'christianchiarulli/nvcode-color-schemes.vim',
  -- {'rockerBOO/boo-colorscheme-nvim', branch = 'main' },

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
  }
}
