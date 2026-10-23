local au = vim.api.nvim_create_autocmd

au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

au("FileType", {
  pattern = "markdown",
  callback = function(ev)
    local root = vim.fs.root(ev.buf, { ".marksman.toml", ".git" })
    if not root then
      return
    end
    local marker = root .. "/.marksman.toml"
    if vim.uv.fs_stat(marker) == nil then
      local fd = vim.uv.fs_open(marker, "w", 420)
      if fd then
        vim.uv.fs_close(fd)
      end
    end
  end,
})
