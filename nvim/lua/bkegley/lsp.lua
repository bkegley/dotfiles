local lspconfig = require'lspconfig'
local completion = require'completion'

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
end

local default_config = {
  on_attach = default_on_attach,
}

local pid = vim.fn.getpid()
local cache_path = vim.fn.stdpath('cache')
local omnisharp_bin = cache_path .. "/lspconfig/omnisharp/run"
local sumneko_lua_root_path = cache_path .. '/lspconfig/sumneko_lua/lua-language-server'

local lua_language_server_path = '/bin/Linux/lua-language-server'
if vim.fn.has('mac') == 1 then
  lua_language_server_path = '/bin/macOS/lua-language-server'
end

local sumneko_lua_binary = sumneko_lua_root_path .. lua_language_server_path

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
lspconfig.terraformls.setup(default_config)
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

local eslint_config = {
  lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
     "%f(%l,%c): %tarning %m",
     "%f(%l,%c): %rror %m"
  },
  rootMarkers = {
     '.git/',
     'package.json',
     '.eslintrc*'
  },
}

lspconfig.efm.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    default_on_attach(client)
  end,
  settings = {
    languages = {
      javascriptreact = {eslint_config},
      ["javascript.jsx"] = {eslint_config},
      typescript = {eslint_config},
      ["typescript.tsx"] = {eslint_config},
      typescriptreact = {eslint_config}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  }
}
