-- ~/.config/nvim/lua/plugins/aerial.lua
return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    -- Priority list of preferred backends for aerial.
    -- This can be a filetype map (see :help aerial-filetype-map)
    backends = { 'treesitter', 'lsp', 'markdown', 'asciidoc', 'man' },

    layout = {
      -- These control the width of the aerial window.
      -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = { 40, 0.2 },
      width = nil,
      min_width = 10,

      -- Determines the default direction to open the aerial window
      default_direction = 'prefer_left',

      -- Determines where the aerial window will be opened
      placement = 'window',
    },

    -- Determines how the aerial window decides which buffer to display symbols for
    attach_mode = 'window',

    -- List of enum values that configure when to auto-close the aerial window
    close_automatic_events = {},

    -- Keymaps in aerial window
    keymaps = {
      ['?'] = 'actions.show_help',
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.jump',
      ['<2-LeftMouse>'] = 'actions.jump',
      ['<C-v>'] = 'actions.jump_vsplit',
      ['<C-s>'] = 'actions.jump_split',
      ['p'] = 'actions.scroll',
      ['<C-j>'] = 'actions.down_and_scroll',
      ['<C-k>'] = 'actions.up_and_scroll',
      ['{'] = 'actions.prev',
      ['}'] = 'actions.next',
      ['[['] = 'actions.prev_up',
      [']]'] = 'actions.next_up',
      ['q'] = 'actions.close',
      ['o'] = 'actions.tree_toggle',
      ['za'] = 'actions.tree_toggle',
      ['O'] = 'actions.tree_toggle_recursive',
      ['zA'] = 'actions.tree_toggle_recursive',
      ['l'] = 'actions.tree_open',
      ['zo'] = 'actions.tree_open',
      ['L'] = 'actions.tree_open_recursive',
      ['zO'] = 'actions.tree_open_recursive',
      ['h'] = 'actions.tree_close',
      ['zc'] = 'actions.tree_close',
      ['H'] = 'actions.tree_close_recursive',
      ['zC'] = 'actions.tree_close_recursive',
      ['zr'] = 'actions.tree_increase_fold_level',
      ['zR'] = 'actions.tree_open_all',
      ['zm'] = 'actions.tree_decrease_fold_level',
      ['zM'] = 'actions.tree_close_all',
      ['zx'] = 'actions.tree_sync_folds',
      ['zX'] = 'actions.tree_sync_folds',
    },

    -- When true, don't load aerial until a command or function is called
    lazy_load = true,

    -- Disable aerial on files with this many lines
    disable_max_lines = 10000,

    -- A list of all symbols to display. Set to false to display all symbols.
    filter_kind = {
      'Class',
      'Constructor',
      'Enum',
      'Function',
      'Interface',
      'Module',
      'Method',
      'Struct',
    },
  },
  config = function(_, opts)
    require('aerial').setup(opts)

    -- Set keymaps
    vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial' })
    vim.keymap.set('n', '<leader>ao', '<cmd>AerialOpen<CR>', { desc = 'Open Aerial' })
    vim.keymap.set('n', '<leader>ac', '<cmd>AerialClose<CR>', { desc = 'Close Aerial' })
    vim.keymap.set('n', '<leader>{', '<cmd>AerialPrev<CR>', { desc = 'Previous symbol' })
    vim.keymap.set('n', '<leader>}', '<cmd>AerialNext<CR>', { desc = 'Next symbol' })
  end,
}
