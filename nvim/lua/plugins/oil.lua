return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<cmd>Oil<CR>" },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 4,
    },
    keymaps = {
      ["q"] = "actions.close",
      ["<Esc>"] = "actions.close",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
    },
  },
}
