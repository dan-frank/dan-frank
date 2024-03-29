local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
-- local util = lspconfig.util

-- Needed for the Lua LSP to understand the Neovim API
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Add nvim-cmp to capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- All servers are installed by Nix
local servers = {
  { name = "bashls",  opts = { filetypes = { "sh", "zsh" } } },
  { name = "cssls",   opts = {} },
  { name = "graphql", opts = {} },
  {
    name = "ltex",
    opts = {
      filetypes = { "latex", "tex", "bib", "markdown", "gitcommit" },
      -- use_spellfile = true,
      settings = {
        ltex = {
          checkFrequency = "save",
          enabled = { "latex", "tex", "bib", "markdown", },
          language = "auto",
          diagnosticSeverity = "information",
          additionalRules = {
            enablePickyRules = true,
            languageModel = "~/.local/share/ngrams",
          },
          disabledRules = {
            -- https://community.languagetool.org/rule/list?lang=en
            en = { "DASH_RULE", "ELLIPSIS", "EN_QUOTES", "WHITESPACE_RULE" },
          },
          -- dictionary = (function()
          --   local files = {}
          --   for _, file in ipairs(vim.api.nvim_get_runtime_file("spell/*.add", true)) do
          --     local lang = vim.fn.fnamemodify(file, ":t:r:r")
          --     local fullpath = vim.fn.fnamemodify(file, ":p")
          --     files[lang] = { ":" .. fullpath }
          --   end

          --   if files.default then
          --     for lang, _ in pairs(files) do
          --       if lang ~= "default" then
          --         vim.list_extend(files[lang], files.default)
          --       end
          --     end
          --     files.default = nil
          --   end
          --   return files
          -- end)(),
        },
      }
    }
  },
  { name = "html",        opts = {} },
  {
    name = "jsonls",
    opts = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
          end
        }
      }
    }
  },
  {
    name = "lua_ls",
    opts = {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = runtime_path,
          },
          -- Get the language server to recognize the `vim` global
          diagnostics = { globals = { "vim" } },
          -- Make the server aware of Neovim runtime files
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          -- Disable telemetry
          telemetry = { enable = false },
        },
      },
    }
  },
  { name = "marksman",    opts = {} },
  { name = "nil_ls",      opts = {} },
  { name = "phpactor",    opts = {} },
  { name = "tailwindcss", opts = {} },
}

-- Load all setups
for _, server in ipairs(servers) do
  -- Default setup
  local setup = {
    capabilities = capabilities,
  }

  -- Merge opts with default setup
  for k, v in pairs(server.opts) do setup[k] = v end

  lspconfig[server.name].setup(setup)
end
