return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    },
    config = function()
      -- `:help lspconfig-all` find your language server e.g. 'lua_ls' and check install instructions
      -- install the language server and make sure it's executable `:echo executable('lua-language-server')`
      require("lspconfig").lua_ls.setup({
        format = {
          indent_size = 2
        }
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })

      -- local npm_root_g_dir = require('config.lsp.npm').get_npm_root()
      -- local vue_language_server_location = npm_root_g_dir .. '/@vue/languge-server'
      -- local vue_typescript_plugin_location = npm_root_g_dir .. '/@vue/typescript-plugin'

      -- typescript
      require 'lspconfig'.ts_ls.setup {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
      }

      -- vue
      require('lspconfig').volar.setup({
        -- add filetypes for typescript, javascript and vue
        filetypes = {
          'vue'
        },
        init_options = {
          vue = {
            -- disable hybrid mode
            hybridMode = false,
          },
        },
      })

      -- load some custom utility functions
      require('config.lsp.utils')
    end,
  }
}
