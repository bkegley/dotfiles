local lspconfig = require'lspconfig'
local cmp_nvim_lsp = require'cmp_nvim_lsp'
local lsp_status = require'lsp-status'

local runtime_path = vim.split(package.path, ';')

local pid = vim.fn.getpid()

local function default_on_attach(client)
  print('Attaching to ' .. client.name)
  lsp_status.on_attach(client)
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
end

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Uncomment this for debugging in ~/.cache/nvim/lsp.log
-- vim.lsp.set_log_level("debug")

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

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

-- Thanks TJ!
local servers = {
  bashls = true,
  cssls = true,
  dockerls = true,
  html = true,
  jsonls = true,
  omnisharp = {
      cmd={vim.fn.stdpath('cache') .. "/lspconfig/omnisharp/run" , "--languageserver" , "--hostPID", tostring(pid) },
  },
  tsserver = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  svelte = true,
  terraformls = true,
  sumneko_lua  = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  vimls = true,
  yamlls = true,
  efm = {
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
  },
}

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())


local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_attach = default_on_attach,
    capabilities = capabilities,
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

