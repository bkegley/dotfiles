local telescope = require 'telescope'
local themes = require 'telescope.themes'

local default_config = {
  shorten_path = true,
  layout_strategy = 'vertical',
  layout_config = {
    --preview_height = 0.4
  }
}


telescope.setup({defaults = default_config})

local theme = themes.get_dropdown{ win_blend = 10, results_height = .25, width = .65, shorten_path = true }

function FindFiles()
  require'telescope.builtin'.find_files(theme)
end

--Not currently working as it sets preview path to cwd (dotfiles dir)
function Dotfiles()
  local config = {}
  for k,v in pairs(theme) do
    config[k] = v
  end

  config.cwd = "~/.config"
  if (os.getenv('DOTFILES_GIT_DIR')) then
    config.cwd = os.getenv('DOTFILES_GIT_DIR')
  else
    print("Set DOTFILES_GIT_DIR env var for this command to work")
    return
  end
  require'telescope.builtin'.find_files(config)
end

function LiveGrep()
  require'telescope.builtin'.live_grep(theme)
end

function GrepString(search)
  local config = {}
  for k,v in pairs(theme) do
    config[k] = v
  end
  config.search = search
  require'telescope.builtin'.grep_string(config)
end

function Buffers()
  require'telescope.builtin'.buffers(theme)
end
