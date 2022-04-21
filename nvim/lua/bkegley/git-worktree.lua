local Worktree = require("git-worktree")

local M = {}
function M.execute(path)
  print(path)
  -- cd path && make init && make configure ; (cd infrastructure && make init) && make configure && rush build --to frontend
end

Worktree.on_tree_change(function(_ --[[op]], path, _ --[[upstream]])
    M.execute(path.path)
end)

return M
