local notes = {}
local ns = vim.api.nvim_create_namespace("review_notes")

local function add_note()
  local file = vim.fn.expand("%:.")
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local line_text = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1] or ""

  vim.ui.input({ prompt = "Review note: " }, function(comment)
    if not comment or comment == "" then
      return
    end
    table.insert(notes, {
      file = file,
      lnum = lnum,
      text = vim.trim(line_text),
      comment = comment,
    })
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, 0, {
      virt_text = { { " [review] " .. comment, "DiagnosticInfo" } },
      sign_text = "",
      sign_hl_group = "DiagnosticSignInfo",
    })
  end)
end

local function list_notes()
  if #notes == 0 then
    vim.notify("No review notes", vim.log.levels.INFO)
    return
  end

  local ok, fzf = pcall(require, "fzf-lua")
  if ok then
    local items = {}
    for i, n in ipairs(notes) do
      items[i] = string.format("%s:%d: %s", n.file, n.lnum, n.comment)
    end
    fzf.fzf_exec(items, {
      actions = {
        ["default"] = function(selected)
          local parts = vim.split(selected[1], ":")
          vim.cmd("edit " .. parts[1])
          vim.api.nvim_win_set_cursor(0, { tonumber(parts[2]), 0 })
        end,
      },
    })
  else
    for _, n in ipairs(notes) do
      print(string.format("%s:%d — %s", n.file, n.lnum, n.comment))
    end
  end
end

local function yank_notes()
  if #notes == 0 then
    vim.notify("No review notes to yank", vim.log.levels.INFO)
    return
  end

  local lines = { "## Review notes", "" }
  for _, n in ipairs(notes) do
    table.insert(lines, string.format("`%s:%d` -- %s", n.file, n.lnum, n.comment))
    table.insert(lines, string.format("> %s", n.text))
    table.insert(lines, "")
  end

  local output = table.concat(lines, "\n")
  vim.fn.setreg("+", output)
  vim.notify(string.format("Yanked %d review notes to clipboard", #notes), vim.log.levels.INFO)
end

local function clear_notes()
  notes = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    end
  end
  vim.notify("Review notes cleared", vim.log.levels.INFO)
end

return {
  dir = ".",
  name = "review-notes",
  keys = {
    { "<leader>ra", add_note, desc = "Add review note" },
    { "<leader>rl", list_notes, desc = "List review notes" },
    { "<leader>ry", yank_notes, desc = "Yank review notes" },
    { "<leader>rc", clear_notes, desc = "Clear review notes" },
  },
}
