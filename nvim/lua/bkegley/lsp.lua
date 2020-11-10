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
