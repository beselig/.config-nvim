return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup { n_lines = 500 }

    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = true }

    require('mini.surround').setup()

    local notify = require 'mini.notify'
    notify.setup()
    vim.notify = notify.make_notify {
      ERROR = { duration = 10000 },
      WARN = { duration = 5000 },
      INFO = { duration = 3000 },
      DEBUG = { duration = 3000 },
      TRACE = { duration = 3000 },
    }

    -- not sure about this one:
    -- require 'mini.jump'jump.setup()

    require('mini.pairs').setup()

    require('mini.misc').setup {
      make_global = { 'put', 'put_text' },
    }

    require('mini.move').setup()

    -- you can configure sections in the statusline by overriding their
    -- default behavior. for example, here we set the section for
    -- cursor location to line:column
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
