-- ~/.config/nvim/lua/plugins/ui.lua
return {
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file explorer' },
      { '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', desc = 'Toggle file explorer on current file' },
      {
        '<leader>er',
        function()
          -- Change nvim-tree root to current working directory
          local nvim_tree = require 'nvim-tree.api'
          nvim_tree.tree.change_root(vim.fn.getcwd())
          vim.notify('NvimTree root changed to: ' .. vim.fn.getcwd(), vim.log.levels.INFO)
        end,
        desc = 'Reset file explorer to cwd',
      },
    },
    config = function()
      require('nvim-tree').setup {
        sync_root_with_cwd = true, -- Always sync with current working directory
        respect_buf_cwd = true, -- Change root when changing buffer CWD
        update_focused_file = {
          enable = true, -- Update tree when changing files
          update_root = true, -- Update root directory as well
        },
        view = {
          width = 35,
          relativenumber = true,
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            glyphs = {
              folder = {
                arrow_closed = '',
                arrow_open = '',
              },
            },
          },
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        filters = {
          custom = { '.DS_Store' },
        },
        git = {
          ignore = false,
        },
      }
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
          component_separators = '|',
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
  },

  -- Buffer line
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version = '*',
    keys = {
      { '<leader>bb', '<cmd>BufferLinePick<CR>', desc = 'Pick buffer' },
      { '<leader>bc', '<cmd>BufferLinePickClose<CR>', desc = 'Pick buffer to close' },
      {
        '<leader>bt',
        function()
          vim.g.bufferline_visible = not vim.g.bufferline_visible
          if vim.g.bufferline_visible then
            vim.opt.showtabline = 2
            vim.notify('Bufferline: visible', vim.log.levels.INFO)
          else
            vim.opt.showtabline = 0
            vim.notify('Bufferline: hidden', vim.log.levels.INFO)
          end
        end,
        desc = 'Toggle bufferline',
      },
    },
    config = function()
      -- Start with bufferline hidden (set to true if you want it visible by default)
      vim.g.bufferline_visible = false
      vim.opt.showtabline = 0

      require('bufferline').setup {
        options = {
          mode = 'buffers',
          themable = true,
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              highlight = 'Directory',
              separator = true,
            },
          },
          separator_style = 'slant',
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level)
            local icon = level:match 'error' and ' ' or ' '
            return ' ' .. icon .. count
          end,
        },
      }
    end,
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
        },
      },
    },
  },

  -- Color highlighter
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  -- EOF scroll padding (keeps scrolloff working at end of file)
  {
    'Aasim-A/scrollEOF.nvim',
    event = 'CursorMoved',
    opts = {},
  },

  -- Zen mode for distraction-free coding
  {
    'folke/zen-mode.nvim',
    keys = {
      {
        '<leader>z',
        function()
          require('zen-mode').toggle { window = { width = vim.g.zen_width or 120 } }
        end,
        desc = 'Toggle Zen Mode',
      },
    },
    config = function()
      -- Store zen width in a global variable (persists during session)
      vim.g.zen_width = vim.g.zen_width or 120

      require('zen-mode').setup {
        window = {
          backdrop = 0.95,
          width = function()
            return vim.g.zen_width
          end,
          height = 1,
          options = {
            signcolumn = 'no',
            number = true,
            relativenumber = true,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = '0',
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
            laststatus = 3,
          },
          twilight = { enabled = false },
          gitsigns = { enabled = false },
          tmux = { enabled = true },
        },
        on_open = function()
          -- Hide incline in zen mode
          local ok, incline = pcall(require, 'incline')
          if ok then
            incline.disable()
          end

          -- Keymaps only active while in zen mode
          vim.keymap.set('n', '<C-Up>', function()
            vim.g.zen_width = vim.g.zen_width + 10
            require('zen-mode').close()
            require('zen-mode').open { window = { width = vim.g.zen_width } }
            vim.notify('Zen width: ' .. vim.g.zen_width, vim.log.levels.INFO)
          end, { buffer = true, desc = 'Increase Zen width' })

          vim.keymap.set('n', '<C-Down>', function()
            vim.g.zen_width = math.max(vim.g.zen_width - 10, 40)
            require('zen-mode').close()
            require('zen-mode').open { window = { width = vim.g.zen_width } }
            vim.notify('Zen width: ' .. vim.g.zen_width, vim.log.levels.INFO)
          end, { buffer = true, desc = 'Decrease Zen width' })
        end,
        on_close = function()
          -- Show incline again when exiting zen mode
          local ok, incline = pcall(require, 'incline')
          if ok then
            incline.enable()
          end
        end,
      }
    end,
  },

  -- Floating filename indicator (incline)
  {
    'b0o/incline.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local devicons = require 'nvim-web-devicons'

      require('incline').setup {
        hide = {
          cursorline = false,
          focused_win = false,
          only_win = false, -- Show even with single window
        },
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 1 },
          placement = {
            horizontal = 'right',
            vertical = 'bottom',
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { ' ', ft_icon, ' ', guifg = ft_color } or '',
            ' ',
            { filename, gui = modified and 'bold,italic' or 'bold' },
            modified and { ' ●', guifg = '#d19a66' } or '',
            ' ',
          }
        end,
      }
    end,
  },

  -- Dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.header.val = {
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '                                                     ',
      }

      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', '<cmd>Telescope find_files<CR>'),
        dashboard.button('n', '  New file', '<cmd>ene <BAR> startinsert<CR>'),
        dashboard.button('r', '  Recent files', '<cmd>Telescope oldfiles<CR>'),
        dashboard.button('g', '  Find text', '<cmd>Telescope live_grep<CR>'),
        dashboard.button('c', '  Config', '<cmd>e $MYVIMRC<CR>'),
        dashboard.button('q', '  Quit', '<cmd>qa<CR>'),
      }

      alpha.setup(dashboard.opts)
    end,
  },
}
