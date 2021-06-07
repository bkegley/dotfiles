local previewers = require'telescope.previewers'

local M = {}

M.previewer = previewers.new_termopen_previewer {
  get_command = function(entry)
    -- git status
    if entry.status == '??' or 'A ' then
      return {'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value}
    end

    -- git commits
    return {'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!'}
  end
}

return M
