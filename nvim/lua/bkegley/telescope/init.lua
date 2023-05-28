local telescope = require 'telescope'
local themes = require 'telescope.themes'
local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local previewers = require 'telescope.previewers'
local quickfix = require 'bkegley.telescope.quickfix'
local delta = require 'bkegley.telescope.delta'

require 'telescope'.setup({
  theme = themes.get_dropdown(),
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    mappings = {},
    file_ignore_patterns = {
      '.git',
      'dist',
      'build',
      'node_modules'
    },
    path_display = { "smart" },
    winblend = 0,
    border = {},
    borderchars = nil,
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      only_sort_text = true,
    },
    grep_string = {
      only_sort_text = true,
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
    git_files = {
      hidden = true,
      show_untracked = true,
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  }
})

require 'telescope'.load_extension('git_worktree')
require 'telescope'.load_extension('file_browser')
require 'telescope'.load_extension('ui-select')
pcall(require 'telescope'.load_extension, 'fzf')

local M = {}


M.find_files = function()
  builtin.find_files()
end

M.dotfiles = function()
  local config = {}

  if (os.getenv('DOTFILES_GIT_DIR')) then
    config.cwd = os.getenv('DOTFILES_GIT_DIR')
  else
    print("Set DOTFILES_GIT_DIR env var for this command to work")
    return
  end
  builtin.find_files(config)
end

M.help_tags = function()
  builtin.help_tags()
end

M.live_grep = function()
  builtin.live_grep()
end

M.grep_string = function(search)
  local config = {
    search = search
  }

  builtin.grep_string(config)
end

M.buffers = function()
  builtin.buffers()
end

M.quickfix = function()
  builtin.quickfix()
end

M.buf_fuzzy_find = function()
  builtin.current_buffer_fuzzy_find()
end

M.search_history = function()
  builtin.search_history()
end

M.git_branches = function()
  builtin.git_branches()
end

M.git_commits = function(opts)
  opts = opts or {}
  opts.previewer = delta.previewer
  builtin.git_commits(opts)
end

M.git_buffer_commits = function(opts)
  opts = opts or {}
  opts.previewer = delta.previewer
  builtin.git_bcommits(opts)
end

M.git_status = function(opts)
  opts = opts or {}
  opts.previewer = delta.previewer
  builtin.git_status(opts)
end

return M
