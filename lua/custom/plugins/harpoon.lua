return {
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    enabled = true,
    config = function()
      require('telescope').load_extension 'harpoon'
      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'
      -- local tmux = require 'harpoon.tmux'
      -- local term = require 'harpoon.term'

      vim.keymap.set('n', '<leader>n', function()
        mark.add_file()
      end, { desc = 'harpoon: add file' })

      vim.keymap.set('n', '<C-q>', function()
        ui.toggle_quick_menu()
      end, { desc = 'harpoon: toggle quick menu' })

      vim.keymap.set('n', '<C-;>', function()
        ui.nav_next()
      end)
      vim.keymap.set('n', '<C-,>', function()
        ui.nav_prev()
      end)

      for i = 1, 9 do
        vim.keymap.set('n', '<C-' .. i .. '>', function()
          ui.nav_file(i)
        end)
      end
    end,
  },
}
