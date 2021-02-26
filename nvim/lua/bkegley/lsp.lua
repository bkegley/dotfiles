local lspconfig = require'lspconfig'
local completion = require'completion'
local lsp_status = require'lsp-status'

lsp_status.register_progress()

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

local function default_on_attach(client)
  print('Attaching to ' .. client.name)
  completion.on_attach(client)
  lsp_status.on_attach(client)
end

local default_config = {
  on_attach = default_on_attach,
  capabilities = lsp_status.capabilities
}

local pid = vim.fn.getpid()
local cache_path = vim.fn.stdpath('cache')
local omnisharp_bin = cache_path .. "/lspconfig/omnisharp/run"
local sumneko_lua_root_path = cache_path .. '/lspconfig/sumneko_lua/lua-language-server'
local sumneko_lua_binary = sumneko_lua_root_path .. '/bin/Linux/lua-language-server'

-- Language Servers
lspconfig.bashls.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.dockerls.setup(default_config)
lspconfig.html.setup(default_config)
lspconfig.jsonls.setup(default_config)
lspconfig.omnisharp.setup({
    cmd={ omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    on_attach = default_on_attach,
})
lspconfig.tsserver.setup(default_config)
lspconfig.svelte.setup(default_config)
lspconfig.sumneko_lua.setup({
    cmd = {sumneko_lua_binary, "-E", sumneko_lua_root_path .. '/main.lua'},
    on_attach = default_on_attach,
    settings = {
      Lua ={
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';')
        },
        diagnostics = {
          globals = {'vim'}
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
          }
        }
      }
    }
})
lspconfig.vimls.setup(default_config)
lspconfig.yamlls.setup(default_config)
