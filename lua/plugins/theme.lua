local macOSDark = vim.fn.system('defaults read -g AppleInterfaceStyle'):gsub('%s+', '')
return {
  {
    'rose-pine/neovim',
    lazy = false,
    priority = 999,
    name = 'rose-pine',
    config = function()
      vim.cmd.hi 'comment gui=none'
      require('rose-pine').setup {
        variant = 'auto', -- auto, main, moon, or dawn
        dark_variant = 'main', -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },

        groups = {
          border = 'muted',
          link = 'iris',
          panel = 'surface',

          error = 'love',
          hint = 'iris',
          info = 'foam',
          note = 'pine',
          todo = 'rose',
          warn = 'gold',

          git_add = 'foam',
          git_change = 'rose',
          git_delete = 'love',
          git_dirty = 'rose',
          git_ignore = 'muted',
          git_merge = 'iris',
          git_rename = 'pine',
          git_stage = 'iris',
          git_text = 'rose',
          git_untracked = 'subtle',

          h1 = 'iris',
          h2 = 'foam',
          h3 = 'rose',
          h4 = 'gold',
          h5 = 'pine',
          h6 = 'foam',
        },

        palette = {
          -- Override the builtin palette per variant
          -- moon = {
          --     base = '#18191a',
          --     overlay = '#363738',
          -- },
        },

        highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
        },

        before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          -- if highlight.undercurl then
          --     highlight.undercurl = false
          -- end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --     highlight.fg = palette.foam
          -- end
        end,
      }

      if macOSDark == 'Dark' then
        vim.cmd 'colorscheme rose-pine-main'
      else
        -- vim.cmd 'colorscheme rose-pine-dawn'
      end
      -- vim.cmd("colorscheme rose-pine-main")
      -- vim.cmd("colorscheme rose-pine-moon")
      -- vim.cmd("colorscheme rose-pine-dawn")
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
      if macOSDark ~= 'Dark' then
        vim.cmd 'colorscheme catppuccin'
      end
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1001,
    config = function()
      -- setup must be called before loading
      -- vim.cmd 'colorscheme github_dark'
      if macOSDark ~= 'Dark' then
        vim.cmd 'colorscheme github_light'
      end
    end,
  },
  { -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-day'

      -- if macOSDark == 'Dark' then
      --   vim.cmd.colorscheme 'tokyonight-moon'
      -- else
      --   vim.cmd.colorscheme 'tokyonight-day'
      -- end

      -- you can configure highlights by doing something like
      vim.cmd.hi 'comment gui=none'
    end,
  },
}
