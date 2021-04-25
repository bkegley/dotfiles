local vim = vim
local actions = require'telescope.actions'

local M = {}
M.add_selection_to_quickfix = function(prompt_bufnr)
  local entry = actions.get_selected_entry(prompt_bufnr)

  local qf_list = {
    {
      bufnr = entry.bufnr,
      filename = entry.filename,
      lnum = entry.lnum,
      col = entry.col,
      text = entry.value,
    }
  }

  local current_qf = vim.fn.getqflist()

  for _, v in pairs(current_qf) do
    table.insert(qf_list, v)
  end

  vim.fn.setqflist(qf_list)
  print('Added ' .. entry.filename .. ' to quickfix')
end

M.remove_selection_from_quickfix = function(prompt_bufnr)
  local entry = actions.get_selected_entry(prompt_bufnr)
  local selected_qf_entry = {
    bufnr = entry.bufnr,
    filename = entry.filename,
    lnum = entry.lnum,
    col = entry.col,
    text = entry.value,
  }

  local qf_list = {}

  local current_qf = vim.fn.getqflist()
  for _, qf_entry in pairs(current_qf) do
      local should_keep = true
      for k, v in pairs(selected_qf_entry) do
        if qf_entry[k] ~= v then
          should_keep = false
          break
        end
      end
      if should_keep then
        table.insert(qf_list, qf_entry)
      end
  end

  vim.fn.setqflist(qf_list)
  actions.close(prompt_bufnr)
end

return M
