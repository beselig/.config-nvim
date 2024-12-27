return { -- autocompletion
  enabled = false,
  'hrsh7th/nvim-cmp',
  event = 'insertenter',
  dependencies = {
    -- snippet engine & its associated nvim-cmp source
    {
      'l3mon4d3/luasnip',
      build = (function()
        -- build step is needed for regex support in snippets
        -- this step is not supported in many windows environments
        -- remove the below condition to re-enable on windows
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    'saadparwaiz1/cmp_luasnip',

    -- adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. they are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',

    -- if you want to add a bunch of pre-configured snippets,
    --    you can use this plugin to help you. it even has snippets
    --    for various frameworks/libraries/etc. but you will have to
    --    set up the ones that are useful for you.
    -- 'rafamadriz/friendly-snippets',
  },
  config = function()
    -- see `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      -- for an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- no, but seriously. please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- select the [n]ext item
        ['<c-n>'] = cmp.mapping.select_next_item(),
        -- select the [p]revious item
        ['<c-p>'] = cmp.mapping.select_prev_item(),

        -- accept ([y]es) the completion.
        --  this will auto-import if your lsp supports it.
        --  this will expand snippets if the lsp sent a snippet.
        ['<c-y>'] = cmp.mapping.confirm { select = true },

        -- manually trigger a completion from nvim-cmp.
        --  generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<c-.>'] = cmp.mapping.complete {},

        -- think of <c-l> as moving to the right of your snippet expansion.
        --  so if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<c-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<c-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    }
  end,
}
