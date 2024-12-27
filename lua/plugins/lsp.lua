return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        'pmizio/typescript-tools.nvim',
        dependencies = {
          {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig'
          },
        }
      },
      {
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
      {
        "saghen/blink.cmp"
      }
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- `:help lspconfig-all` find your language server e.g. 'lua_ls' and check install instructions
      -- install the language server and make sure it's executable `:echo executable('lua-language-server')`
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
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
      -- see typescript-tools.lua
      -- require 'lspconfig'.ts_ls.setup {
      --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
      -- }

      local node_modules_dir = vim.fn.finddir('node_modules', vim.fn.stdpath('config'))
      if not node_modules_dir then
        vim.notify(
          'make sure to run npm install inside ' ..
          vim.fn.stdpath('config') .. ' or volar and ts_ls might not work properly',
          vim.log.levels.WARN)
      end

      -- vue
      require('lspconfig').volar.setup({
        capabilities = capabilities,
        -- add filetypes for typescript, javascript and vue
        filetypes = {
          'vue'
        },
        init_options = {
          typescript = {
            -- replace with your global TypeScript library path
            tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib'
          },
          vue = {
            -- disable hybrid mode
            hybridMode = false,
          },
        },
      })

      -- typescript-tools
      require('typescript-tools').setup {
        capabilities = capabilities,
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
        },
        settings = {
          expose_as_code_action = { 'add_missing_imports', 'remove_unused' },
        },
      }

      -- load some custom utility functions
      require('config.lsp.utils')
    end,
  },
}
