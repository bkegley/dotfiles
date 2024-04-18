return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      'haydenmeade/neotest-jest',
    },
    opts = {
      status = { virtual_text = true },
      output = { open_on_run = true },
    },
    config = function(_, options)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      options.adapters = {
        require('neotest-jest')({
          jestCommand = "npm test --",
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      }
      require('neotest').setup(options)
    end,
    keys = {
      {
        "<leader>tt",
        function() require("neotest").run.run(vim.fn.expand("%")) end,
        desc =
        "Run File"
      },
      {
        "<leader>tT",
        function() require("neotest").run.run(vim.loop.cwd()) end,
        desc =
        "Run All Test Files"
      },
      {
        "<leader>tr",
        function() require("neotest").run.run() end,
        desc =
        "Run Nearest"
      },
      {
        "<leader>ts",
        function() require("neotest").summary.toggle() end,
        desc =
        "Toggle Summary"
      },
      {
        "<leader>to",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc =
        "Show Output"
      },
      {
        "<leader>tO",
        function() require("neotest").output_panel.toggle() end,
        desc =
        "Toggle Output Panel"
      },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    keys = {
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
    },
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      right = {
        { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
      }
    },
  }
}
