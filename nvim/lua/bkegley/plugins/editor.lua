return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
  },

  -- unsure
  -- 'jose-elias-alvarez/nvim-lsp-ts-utils',
  -- 'onsails/lspkind-nvim',
  --
  -- 'jremmen/vim-ripgrep',
  -- 'airblade/vim-rooter',

  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-file-browser.nvim'
    }
  },

  -- 'preservim/nerdtree',
  -- 'mbbill/undotree',
  -- {
  -- 'pwntester/octo.nvim',
  -- config=function()
  -- require'octo'.setup()
  -- end,
  -- },
  'jiangmiao/auto-pairs',
  -- 'sheerun/vim-polyglot',
  -- {
  -- 'theprimeagen/harpoon',
  -- config = function()
  -- require('harpoon').setup {}
  -- end,
  -- },
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
  { 'prettier/vim-prettier', run = 'yarn install' },
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

  'github/copilot.vim'
}
