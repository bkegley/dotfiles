local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

return packer.startup(function()
  local use = use

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-cmdline'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'onsails/lspkind-nvim'

  use 'nvim-lua/lsp-status.nvim'
  use 'anott03/nvim-lspinstall'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'
  use 'airblade/vim-rooter'
  use 'preservim/nerdtree'
  use 'mbbill/undotree'
  use {
    'pwntester/octo.nvim',
    config=function()
      require'octo'.setup()
    end,
  }
  use {'kyazdani42/nvim-web-devicons'}
  use 'jiangmiao/auto-pairs'
  use 'sheerun/vim-polyglot'
  use {
    'theprimeagen/git-worktree.nvim',
    config = function()
      require('git-worktree').setup {}
    end,
  }
  use {
    'theprimeagen/harpoon',
    config = function()
      require('harpoon').setup {}
    end,
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- js/ts
  use 'leafgarland/typescript-vim'
  use 'pangloss/vim-javascript'
  use 'peitalin/vim-jsx-typescript'
  use {'prettier/vim-prettier', run = 'yarn install' }
  use 'preservim/nerdcommenter'

  -- rs
  use 'rust-lang/rust.vim'

  -- aesthetics
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'

  use 'tjdevries/colorbuddy.nvim'
  use 'bkegley/gloombuddy'
  use 'mhartington/oceanic-next'
  use 'relastle/bluewery'
  use 'jaredgorski/fogbell.vim'
  use 'carstenkj02/dosbox-vim'
  use 'ghifarit53/tokyonight-vim'
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use {'rockerBOO/boo-colorscheme-nvim', branch = 'main' }
  end
)
