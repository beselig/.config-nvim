return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      -- local mason_registry = require 'mason-registry'
      -- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

      require('typescript-tools').setup {
        -- init_options = {
        --   plugins = {
        --     {
        --       name = '@vue/typescript-plugin',
        --       location = vue_language_server_path,
        --       languages = { 'vue' },
        --     },
        --   },
        -- },
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          -- 'vue',
        },
        settings = {
          expose_as_code_action = { 'add_missing_imports', 'remove_unused' },
        },
      }
      -- require('lspconfig').volar.setup {}
    end,
  },
}
