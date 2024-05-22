-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'fatih/vim-go',
  {
    'averms/black-nvim',
    config = function()
      vim.g.python3_host_prog = '/Users/Benno/.local/venv/nvim/bin/python'
    end,
  },
}
