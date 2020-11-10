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

function LiveGrep()
  require'telescope.builtin'.live_grep(theme)
end

function Buffers()
  require'telescope.builtin'.buffers(theme)
end
