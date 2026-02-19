return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>dv", "<cmd>DiffviewOpen<CR>" },
      { "<leader>dh", "<cmd>DiffviewFileHistory %<CR>" },
      { "<leader>dc", "<cmd>DiffviewClose<CR>" },
    },
    opts = {},
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    opts = {},
  },
  {
    "theprimeagen/git-worktree.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ws", function() require("git-worktree").switch_worktree() end },
      { "<leader>wc", function() require("git-worktree").create_worktree() end },
    },
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", gs.blame_line, "Blame line")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hS", gs.stage_hunk, "Stage hunk")
      end,
    },
  },
}
