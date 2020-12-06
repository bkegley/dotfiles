local telescope = require 'telescope'
local themes = require 'telescope.themes'

local default_config = themes.get_dropdown{ win_blend = 10, results_height = .25, width = .65, shorten_path = true }

telescope.setup({defaults = default_config})

function FindFiles()
  require'telescope.builtin'.find_files()
end

function Dotfiles()
  local config = {}

  if (os.getenv('DOTFILES_GIT_DIR')) then
    config.cwd = os.getenv('DOTFILES_GIT_DIR')
  else
    print("Set DOTFILES_GIT_DIR env var for this command to work")
    return
  end
  require'telescope.builtin'.find_files(config)
end

function HelpTags()
  require'telescope.builtin'.help_tags()
end

function LiveGrep()
  require'telescope.builtin'.live_grep()
end

function GrepString(search)
  local config = {
    search = search
  }

  require'telescope.builtin'.grep_string(config)
end

function Buffers()
  require'telescope.builtin'.buffers()
end
