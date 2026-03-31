-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
      { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = 'Live grep' },
      { '<leader>fb', '<cmd>Telescope buffers<CR>', desc = 'Find buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = 'Help tags' },
      { '<leader>fr', '<cmd>Telescope oldfiles<CR>', desc = 'Recent files' },
      { '<leader>fc', '<cmd>Telescope grep_string<CR>', desc = 'Find string under cursor' },
      { '<leader>fk', '<cmd>Telescope keymaps<CR>', desc = 'Find keymaps' },
      { '<leader>fs', '<cmd>Telescope git_status<CR>', desc = 'Git status' },
      -- Custom colorscheme picker that only shows your installed themes
      {
        '<leader>ft',
        function()
          -- Only these colorschemes are installed via colorscheme.lua
          local installed_themes = {
            -- Nordic
            'nordic',
            -- OneDark
            'onedark',
            'onedark_vivid',
            'onedark_dark',
            'onelight',
            -- Nightfox
            'nightfox',
            'nordfox',
            'terafox',
            'carbonfox',
            'dawnfox',
            'duskfox',
            -- Everforest
            'everforest',
            -- Kanagawa
            'kanagawa',
            'kanagawa-wave',
            'kanagawa-dragon',
            'kanagawa-lotus',
            -- GitHub
            'github_dark',
            'github_dark_default',
            'github_dark_dimmed',
            'github_light',
            'github_light_default',
            -- Monokai
            'monokai',
            'monokai_pro',
            'monokai_soda',
            'monokai_ristretto',
            -- Catppuccin
            'catppuccin',
            'catppuccin-latte',
            'catppuccin-frappe',
            'catppuccin-macchiato',
            'catppuccin-mocha',
            -- Tokyo Night
            'tokyonight',
            'tokyonight-night',
            'tokyonight-storm',
            'tokyonight-moon',
            'tokyonight-day',
            -- Rose Pine
            'rose-pine',
            'rose-pine-main',
            'rose-pine-moon',
            'rose-pine-dawn',
            -- Gruvbox
            'gruvbox',
            -- Dracula
            'dracula',
            'dracula-soft',
          }
          require('telescope.builtin').colorscheme {
            enable_preview = true,
            colors = installed_themes,
          }
        end,
        desc = 'Colorschemes',
      },
    },
    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'

      telescope.setup {
        defaults = {
          layout_config = {
            width = 0.95,
            height = 0.90,
            preview_cutoff = 40,
            horizontal = {
              preview_width = 0.55,
            },
          },
          prompt_prefix = '  ',
          selection_caret = ' ',
          path_display = { 'smart' },
          file_ignore_patterns = {
            -- Git
            '.git/',
            -- Python / Django
            '.venv/',
            'venv/',
            '__pycache__/',
            '%.pyc',
            '%.egg%-info/',
            'staticfiles/',
            'media/',
            'migrations/',
            '.mypy_cache/',
            -- JS / React / Vite
            'node_modules/',
            'dist/',
            'build/',
            '.next/',
            'coverage/',
            '%.min%.js',
            '%.min%.css',
            -- General
            'target/',
            '%.lock',
            '%.sqlite3',
          },
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              ['<C-x>'] = actions.delete_buffer,
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
            n = {
              ['q'] = actions.close,
              ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              ['<C-x>'] = actions.delete_buffer,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          buffers = {
            sort_mru = true,
            sort_lastused = true,
          },
          colorscheme = {
            enable_preview = true,
          },
          lsp_definitions = {
            file_ignore_patterns = {},
          },
          lsp_references = {
            file_ignore_patterns = {},
          },
          lsp_implementations = {
            file_ignore_patterns = {},
          },
          lsp_type_definitions = {
            file_ignore_patterns = {},
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      }

      telescope.load_extension 'fzf'
    end,
  },
}
