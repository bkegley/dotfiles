local nvim_lsp = require'nvim_lsp'
local nvim_completion = require'completion'
local nvim_diagnostic = require'diagnostic'

local lsp_status = require'lsp-status'
lsp_status.register_progress()

local function default_on_attach(client)
  nvim_completion.on_attach(client)
  lsp_status.on_attach(client)
  nvim_diagnostic.on_attach(client)
end

local default_config = {
  on_attach = default_on_attach,
  capabilities = lsp_status.capabilities
}

nvim_lsp.tsserver.setup(default_config)


