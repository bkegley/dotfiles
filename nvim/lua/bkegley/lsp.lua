local nvim_lsp = require'lspconfig'
local nvim_completion = require'completion'

local lsp_status = require'lsp-status'
lsp_status.register_progress()

-- Thanks TJ!
local key_mapper = function(mode, key, result)
  -- uses nvim_buf_set_keymap instead of nvim_set_keymap to allow buftype specific keymaps
  -- use vim.api.nvim_buf_get_option(0, 'filetype') to check filetype
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

-- Diagnostics
local function setup_diagnostics()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = false,
      signs = true,
      update_in_insert = true,
    }
  )

  key_mapper('n', '<leader>dn', ':lua vim.lsp.diagnostic.goto_next()<CR>')
  key_mapper('n', '<leader>dp', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
  key_mapper('n', '<leader>ds', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
end

local function default_on_attach(client)
  nvim_completion.on_attach(client)
  lsp_status.on_attach(client)

  setup_diagnostics()
end

local default_config = {
  on_attach = default_on_attach,
  capabilities = lsp_status.capabilities
}

-- Language Servers
nvim_lsp.bashls.setup(default_config)
nvim_lsp.cssls.setup(default_config)
nvim_lsp.dockerls.setup(default_config)
nvim_lsp.html.setup(default_config)
nvim_lsp.jsonls.setup(default_config)
nvim_lsp.omnisharp.setup(default_config)
nvim_lsp.tsserver.setup(default_config)
nvim_lsp.sumneko_lua.setup(default_config)
nvim_lsp.vimls.setup(default_config)
nvim_lsp.yamlls.setup(default_config)
