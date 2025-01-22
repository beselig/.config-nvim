return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
      },
      {
        'pmizio/typescript-tools.nvim',
        dependencies = {
          {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
          },
        },
      },
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
      {
        'saghen/blink.cmp',
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      ---@diagnostic disable-next-line: param-type-mismatch
      local node_modules_dir = vim.fn.finddir('node_modules', vim.fn.stdpath 'config')
      if not node_modules_dir then
        vim.notify('make sure to run npm install inside ' .. vim.fn.stdpath 'config' .. ' or volar and ts_ls might not work properly', vim.log.levels.WARN)
      end

      local npm_root_g_dir = require('config.lsp.npm').get_npm_root()
      local vue_language_server_location = npm_root_g_dir .. '/@vue/languge-server'

      -- MASON
      local servers = {
        -- clangd = {},
        gopls = {},
        pyright = {},
        volar = {
          capabilities = capabilities,
          -- add filetypes for typescript, javascript and vue
          filetypes = {
            'vue',
            -- 'typescript',
            -- 'typescriptreact',
            -- 'javascript',
            -- 'javascriptreact',
          },
          init_options = {
            typescript = {
              -- replace with your global TypeScript library path
              tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
            },
            vue = {
              -- disable hybrid mode
              hybridMode = false,
            },
          },
        },
        html = {},

        lua_ls = {
          -- cmd = {...},
          capabilities = capabilities,
          format = {
            indent_size = 2,
          },
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
        'tailwindcss-language-server',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        automatic_installation = false,
        ensure_installed,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- load some custom utility functions
      require 'config.lsp.utils'

      -- typescript-tools
      require('typescript-tools').setup {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          -- 'vue',
        },
        settings = {
          expose_as_code_action = { 'add_missing_imports', 'remove_unused' },
          tsserver_path = node_modules_dir .. 'node_modules/typescript/lib',
          -- tsserver_plugins = {
          --   -- Seemingly this is enough, no name, location or languages needed.
          --   '@vue/typescript-plugin',
          -- },
        },
      }
    end,
  },
}
