return {
  'leath-dub/snipe.nvim',
  enabled = false,
  keys = {
    {
      '<C-q>',
      function()
        require('snipe').open_buffer_menu()
      end,
      desc = 'Open Snipe buffer menu',
    },
  },
  opts = {
    hints = { dictionary = '][poiiu' },
  },
}
