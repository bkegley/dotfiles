return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<C-p>", function() require("fzf-lua").files() end },
    { "<C-l>", function() require("fzf-lua").resume() end },
    { "<leader>fs", function() require("fzf-lua").live_grep() end },
    { "<leader>fw", function() require("fzf-lua").grep_cword() end },
    { "<leader>fh", function() require("fzf-lua").helptags() end },
    { "<leader>fb", function() require("fzf-lua").buffers() end },
    { "<leader>/", function() require("fzf-lua").lgrep_curbuf() end },
    { "<leader>f/", function() require("fzf-lua").search_history() end },
    { "<leader>fq", function() require("fzf-lua").quickfix() end },
    { "<leader>gb", function() require("fzf-lua").git_branches() end },
    { "<leader>gc", function() require("fzf-lua").git_commits() end },
    { "<leader>gbc", function() require("fzf-lua").git_bcommits() end },
    { "<leader>gs", function() require("fzf-lua").git_status() end },
    -- LSP pickers
    { "gi", function() require("fzf-lua").lsp_implementations() end },
    { "gw", function() require("fzf-lua").lsp_document_symbols() end },
    { "gW", function() require("fzf-lua").lsp_workspace_symbols() end },
    { "gr", function() require("fzf-lua").lsp_references() end },
    { "<leader>da", function() require("fzf-lua").diagnostics_workspace() end },
  },
  opts = {
    winopts = {
      height = 0.85,
      width = 0.99,
      preview = { layout = "vertical" },
    },
    keymap = {
      fzf = {
        ["esc"] = "abort",
      },
    },
    git = {
      commits = { preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS" },
      bcommits = { preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS" },
      status = { preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS" },
    },
  },
}
