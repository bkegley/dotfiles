return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "bashls",
        "cssls",
        "dockerls",
        "html",
        "jsonls",
        "yamlls",
        "terraformls",
        "svelte",
        "biome",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.diagnostic.config({
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              telemetry = { enable = false },
            },
          },
        },
        ts_ls = {},
        bashls = {},
        cssls = {},
        dockerls = {},
        html = {},
        jsonls = {},
        yamlls = {},
        terraformls = {},
        svelte = {},
        biome = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(server, config)
      end
      vim.lsp.enable(vim.tbl_keys(servers))
    end,
  },
}
