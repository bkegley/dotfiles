return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "macchiato",
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      mason = true,
      native_lsp = { enabled = true },
      diffview = true,
      harpoon = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
