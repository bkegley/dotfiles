return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
   {
    'theprimeagen/git-worktree.nvim',
    config = function()
      require('git-worktree').setup()
    end,
  },
}
