local telescope = require 'telescope'
local themes = require 'telescope.themes'

local default_config = themes.get_dropdown{ win_blend = 10, results_height = .25, width = .65, shorten_path = true }

telescope.setup({defaults = default_config})

local M = {}


M.find_files = function()
  require'telescope.builtin'.find_files()
end

M.dotfiles = function()
  local config = {}

  if (os.getenv('DOTFILES_GIT_DIR')) then
    config.cwd = os.getenv('DOTFILES_GIT_DIR')
  else
    print("Set DOTFILES_GIT_DIR env var for this command to work")
    return
  end
  require'telescope.builtin'.find_files(config)
end

M.help_tags = function()
  require'telescope.builtin'.help_tags()
end

M.live_grep = function()
  require'telescope.builtin'.live_grep()
end

M.grep_string = function(search)
  local config = {
    search = search
  }

  require'telescope.builtin'.grep_string(config)
end

M.buffers = function()
  require'telescope.builtin'.buffers()
end

return M
