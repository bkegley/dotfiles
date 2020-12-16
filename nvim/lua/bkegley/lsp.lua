local lspconfig = require'lspconfig'
local completion = require'completion'
local lsp_status = require'lsp-status'

lsp_status.register_progress()

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
end

local function default_on_attach(client)
  print('Attaching to ' .. client.name)
  completion.on_attach(client)
  lsp_status.on_attach(client)

  setup_diagnostics()
end

local default_config = {
  on_attach = default_on_attach,
  capabilities = lsp_status.capabilities
}

-- Language Servers
lspconfig.bashls.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.dockerls.setup(default_config)
lspconfig.html.setup(default_config)
lspconfig.jsonls.setup(default_config)
lspconfig.omnisharp.setup(default_config)
lspconfig.tsserver.setup(default_config)
lspconfig.sumneko_lua.setup(default_config)
lspconfig.vimls.setup(default_config)
lspconfig.yamlls.setup(default_config)
