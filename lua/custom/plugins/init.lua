return {
  'fatih/vim-go',
  {
    'averms/black-nvim',
    config = function()
      vim.g.python3_host_prog = '/Users/Benno/.local/venv/nvim/bin/python'
    end,
  },
}
