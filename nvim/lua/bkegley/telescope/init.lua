local vim = vim
local telescope = require'telescope'
local themes = require'telescope.themes'
local builtin = require'telescope.builtin'
local actions = require'telescope.actions'
local previewers = require'telescope.previewers'
local quickfix = require'bkegley.telescope.quickfix'
local relative_grep = require'bkegley.telescope.relative_grep'
local delta = require'bkegley.telescope.delta'


local defaults = {
  mappings = {
    i = {
      ["<esc>"] = actions.close,
      ["<C-a>"] = quickfix.add_selection_to_quickfix,
      ["<C-q>"] = quickfix.remove_selection_from_quickfix
    }
  }
}


local theme_defaults = themes.get_dropdown{ win_blend = 10, results_height = .25, width = .65, shorten_path = true }

telescope.setup({
  defaults = vim.tbl_extend('error', theme_defaults, defaults, {
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new
  })
})

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

M.relative_grep = function()
  relative_grep.relative_grep({hidden = true})
end

return M
