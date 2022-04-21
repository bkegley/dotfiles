local harpoon = require'harpoon'

local M = {}

M.marks = function(opts)
  opts = opts or {}
  harpoon.marks(vim.tbl_deep_extend(opts, {
    prompt_title = "Harpoon It",
  }))
end

return M
