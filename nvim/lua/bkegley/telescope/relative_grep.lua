local vim = vim
local builtin = require'telescope.builtin'
local actions = require'telescope.actions'
local action_state = require('telescope.actions.state')
local action_set = require('telescope.actions.set')
local finders = require'telescope.finders'
local pickers = require'telescope.pickers'

local scan = require('plenary.scandir')
local Path = require('plenary.path')
local os_sep = Path.path.sep
local conf = require('telescope.config').values

local M = {}

M.relative_grep = function(opts)
  opts.depth = opts.depth or 1
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  local new_finder = function(path)
      opts.cwd = path
      local data = {}

     scan.scan_dir(path, {
        hidden = opts.hidden or false,
        add_dirs = true,
        depth = opts.depth,
        on_insert = function(entry, typ)
          if typ == 'directory' then
            table.insert(data, entry .. os_sep)
          end
        end
      })
      table.insert(data, 1, '../')

      return finders.new_table {
        results = data,
        entry_maker = (function()
          local tele_path = require'telescope.path'
          local gen = require('telescope.make_entry').gen_from_file(opts)
          return function(entry)
            local tmp = gen(entry)
            tmp.ordinal = tele_path.make_relative(entry, opts.cwd)
            return tmp
          end
        end)()
      }
  end

  pickers.new(opts, {
    prompt_title = 'Relative Live Grep',
    finder = new_finder(opts.cwd),
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      action_set.select:replace_if(function()
        return action_state.get_selected_entry().path:sub(-1) == os_sep
      end, function()
        local new_cwd = vim.fn.expand(action_state.get_selected_entry().path:sub(1, -2))
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker.cwd = new_cwd
        current_picker:refresh(new_finder(new_cwd), { reset_prompt = true })
      end)

      local grep_selected_dir = function()
        local entry = action_state.get_selected_entry(prompt_bufnr)

        actions._close(prompt_bufnr, true)
        local config = {}

        local new_cwd = vim.fn.expand(action_state.get_selected_entry().path:sub(1, -2))
        config.cwd = entry and new_cwd or vim.loop.cwd()
        builtin.live_grep(config)
      end

      map('i', '<C-f>', grep_selected_dir)
      map('n', '<C-f>', grep_selected_dir)
      return true
    end,
  }):find()
end

return M
