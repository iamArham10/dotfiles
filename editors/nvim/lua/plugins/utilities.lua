-- ~/.config/nvim/lua/plugins/utilities.lua
return {
  -- Flash for fast navigation
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
    },
    opts = {},
  },

  -- Harpoon for quick file switching
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>A', function() require('harpoon'):list():add() end, desc = 'Harpoon add' },
      { '<C-e>', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = 'Harpoon menu' },
      { '<leader>1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon 1' },
      { '<leader>2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon 2' },
      { '<leader>3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon 3' },
      { '<leader>4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon 4' },
    },
    config = function() require('harpoon'):setup() end,
  },

  -- Spectre for project-wide find and replace
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>S', function() require('spectre').toggle() end, desc = 'Toggle Spectre' },
      { '<leader>sw', function() require('spectre').open_visual({ select_word = true }) end, desc = 'Search current word' },
    },
  },

  -- Undotree for undo history visualization
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle Undotree' },
    },
  },

  -- Dressing for better UI popups
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Which-key for keybinding hints
  -- Which-key for keybinding hints
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')
      wk.setup({
        win = {
          border = 'rounded',
        },
      })
      wk.add({
        { '<leader>f', group = 'Find' },
        { '<leader>b', group = 'Buffer' },
        { '<leader>c', group = 'Code' },
        { '<leader>d', group = 'Diagnostics' },
        { '<leader>g', group = 'Git' },
        { '<leader>h', group = 'Hunk' },
        { '<leader>s', group = 'Split' },
        { '<leader>t', group = 'Tab/Toggle' },
        { '<leader>u', group = 'UI' },
        { '<leader>m', group = 'Format' },
        { '<leader>r', group = 'Rename' },
        { '<leader>x', group = 'Trouble' },
      })
    end,
  },

  -- Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      local autopairs = require('nvim-autopairs')
      autopairs.setup({
        check_ts = true,
        disable_filetype = { 'TelescopePrompt', 'vim' },
      })

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- Auto close HTML/JSX/XML tags
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        },
        per_filetype = {
          html = {
            enable_close = true,
          },
        },
      })
    end,
  },

  -- Comment toggling
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('Comment').setup({
        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
      })
    end,
  },

  -- Surround selections
  {
    'kylechui/nvim-surround',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('nvim-surround').setup()
    end,
  },

  -- Better escape from insert mode
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup({
        timeout = 200,
        default_mappings = false,
        mappings = {
          i = {
            j = {
              k = '<Esc>',
              j = '<Esc>',
            },
          },
        },
      })
    end,
  },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<C-\\>', '<cmd>ToggleTerm<CR>', desc = 'Toggle terminal' },
      { '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', desc = 'Float terminal' },
      { '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', desc = 'Horizontal terminal' },
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', desc = 'Vertical terminal' },
    },
    config = function()
      require('toggleterm').setup({
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
        },
      })
    end,
  },

  -- Trouble for diagnostics
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Toggle Trouble' },
      { '<leader>xw', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Workspace diagnostics' },
      { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Document diagnostics' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<CR>', desc = 'Quickfix list' },
      { '<leader>xl', '<cmd>Trouble loclist toggle<CR>', desc = 'Location list' },
      { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<CR>', desc = 'Symbols' },
    },
    opts = {},
  },

  -- Todo comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('todo-comments').setup()
      vim.keymap.set('n', '<leader>fT', '<cmd>TodoTelescope<CR>', { desc = 'Find todos' })
    end,
  },

}
