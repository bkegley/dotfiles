local au = vim.api.nvim_create_autocmd

au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
