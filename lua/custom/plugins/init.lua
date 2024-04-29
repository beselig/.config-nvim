-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'github/copilot.vim',
    config = function()
      -- vim.keymap.set('i', '', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      vim.g.copilot_node_command = '/Users/Benno/.nvm/versions/node/v20.11.1/bin/node'
      vim.g.copilot_workspace_folders = { '~/projects/wurzelkind' }
      vim.g.copilot_no_tab_map = true
    end,
  },
  'fatih/vim-go',
  {
    'averms/black-nvim',
    config = function()
      vim.g.python3_host_prog = '/Users/Benno/.local/venv/nvim/bin/python'
    end,
  },

  -- require './typescript-tools',
}
