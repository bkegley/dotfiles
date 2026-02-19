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
  },
}
