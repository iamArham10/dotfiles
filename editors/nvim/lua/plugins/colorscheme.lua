-- ~/.config/nvim/lua/plugins/colorscheme.lua
-- Optimized colorscheme configuration with only essential themes

-- Active theme configuration
local default_theme = 'nordic' -- Fallback theme
local default_variant = nil -- Fallback variant

-- Persistence: save/load colorscheme from cache
local cache_file = vim.fn.stdpath('cache') .. '/colorscheme.json'

local function load_saved_theme()
  -- Use pcall to handle missing file gracefully without errors
  local ok, content = pcall(function()
    local f = io.open(cache_file, 'r')
    if not f then return nil end
    local data = f:read('*a')
    f:close()
    return data
  end)
  if ok and content then
    local parse_ok, data = pcall(vim.json.decode, content)
    if parse_ok and data then
      return data.theme, data.variant
    end
  end
  return nil, nil
end

local function save_theme(theme, variant)
  local f = io.open(cache_file, 'w')
  if f then
    f:write(vim.json.encode({ theme = theme, variant = variant }))
    f:close()
  end
end

-- Load saved theme or use defaults
local saved_theme, saved_variant = load_saved_theme()
local active_theme = saved_theme or default_theme
local active_variant = saved_variant or default_variant

-- Auto-save when colorscheme changes
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('ColorSchemePersist', { clear = true }),
  callback = function(args)
    local scheme = args.match
    local theme, variant = scheme:match('^([^-]+)-(.+)$')
    if not theme then
      theme = scheme
      variant = nil
    end
    save_theme(theme, variant)
  end,
})

return {
  -- Nordic - Nord-inspired with better contrast
  {
    'AlexvZyl/nordic.nvim',
    lazy = active_theme ~= 'nordic',
    priority = 1000,
    config = function()
      local ok, nordic = pcall(require, 'nordic')
      if ok and nordic.setup then
        pcall(nordic.setup, {})
      end
      if active_theme == 'nordic' then
        vim.cmd.colorscheme('nordic')
      end
    end,
  },

  -- OneDark - Atom-inspired theme
  {
    'olimorris/onedarkpro.nvim',
    lazy = active_theme ~= 'onedark',
    priority = 1000,
    config = function()
      require('onedarkpro').setup({
        styles = {
          comments = 'italic',
          keywords = 'bold',
          functions = 'bold',
        },
        options = {
          transparency = false,
          terminal_colors = true,
          cursorline = true,
        },
      })
      if active_theme == 'onedark' then
        vim.cmd.colorscheme(active_variant or 'onedark')
      end
    end,
  },

  -- Nightfox (includes nordfox variant)
  {
    'EdenEast/nightfox.nvim',
    lazy = active_theme ~= 'nightfox' and active_theme ~= 'nordfox',
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = false,
          terminal_colors = true,
          dim_inactive = true,
          styles = {
            comments = 'italic',
            keywords = 'bold',
            functions = 'bold,italic',
          },
        },
      })
      if active_theme == 'nightfox' or active_theme == 'nordfox' then
        vim.cmd.colorscheme(active_variant or active_theme)
      end
    end,
  },

  -- Everforest - Green-based comfortable theme
  {
    'sainnhe/everforest',
    lazy = active_theme ~= 'everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_background = active_variant or 'medium'
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_dim_inactive_windows = 1
      vim.g.everforest_better_performance = 1
      if active_theme == 'everforest' then
        vim.cmd.colorscheme('everforest')
      end
    end,
  },

  -- Kanagawa - Inspired by Katsushika Hokusai (includes lotus light variant)
  {
    'rebelot/kanagawa.nvim',
    lazy = active_theme ~= 'kanagawa',
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        theme = active_variant or 'wave',
        dimInactive = true,
        terminalColors = true,
      })
      if active_theme == 'kanagawa' then
        vim.cmd.colorscheme('kanagawa')
      end
    end,
  },

  -- GitHub Theme - Official GitHub colors
  {
    'projekt0n/github-nvim-theme',
    lazy = active_theme ~= 'github',
    priority = 1000,
    config = function()
      require('github-theme').setup({
        options = {
          transparent = false,
          terminal_colors = true,
          dim_inactive = true,
          styles = {
            comments = 'italic',
            keywords = 'bold',
          },
        },
      })
      if active_theme == 'github' then
        vim.cmd.colorscheme(active_variant or 'github_dark')
      end
    end,
  },

  -- Monokai - Classic monokai theme
  {
    'tanvirtin/monokai.nvim',
    lazy = active_theme ~= 'monokai',
    priority = 1000,
    config = function()
      require('monokai').setup({})
      if active_theme == 'monokai' then
        vim.cmd.colorscheme('monokai')
      end
    end,
  },

  -- Catppuccin - Soothing pastel theme (latte, frappe, macchiato, mocha)
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = active_theme ~= 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = active_variant or 'mocha',
        transparent_background = false,
        term_colors = true,
        dim_inactive = {
          enabled = true,
        },
        styles = {
          comments = { 'italic' },
          keywords = { 'bold' },
          functions = { 'bold' },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          telescope = { enabled = true },
          flash = true,
          which_key = true,
          harpoon = true,
        },
      })
      if active_theme == 'catppuccin' then
        vim.cmd.colorscheme('catppuccin')
      end
    end,
  },

  -- Tokyo Night - Clean dark theme with storm, night, moon, and day variants
  {
    'folke/tokyonight.nvim',
    lazy = active_theme ~= 'tokyonight',
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = active_variant or 'storm',
        terminal_colors = true,
        dim_inactive = true,
        styles = {
          comments = { italic = true },
          keywords = { bold = true },
          functions = { bold = true },
        },
      })
      if active_theme == 'tokyonight' then
        vim.cmd.colorscheme('tokyonight')
      end
    end,
  },

  -- Rose Pine - Elegant, muted theme (main, moon, dawn)
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = active_theme ~= 'rose',
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        variant = active_variant or 'main',
        dim_inactive_windows = true,
        styles = {
          italic = true,
          bold = true,
        },
      })
      if active_theme == 'rose' then
        vim.cmd.colorscheme('rose-pine')
      end
    end,
  },

  -- Gruvbox - Classic retro warm theme (dark and light)
  {
    'ellisonleao/gruvbox.nvim',
    lazy = active_theme ~= 'gruvbox',
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        terminal_colors = true,
        dim_inactive = true,
        italic = {
          strings = false,
          emphasis = true,
          comments = true,
          operators = false,
        },
        bold = true,
      })
      if active_theme == 'gruvbox' then
        vim.cmd.colorscheme('gruvbox')
      end
    end,
  },

  -- Dracula - Iconic dark purple theme
  {
    'Mofiqul/dracula.nvim',
    lazy = active_theme ~= 'dracula',
    priority = 1000,
    config = function()
      require('dracula').setup({
        italic_comment = true,
      })
      if active_theme == 'dracula' then
        vim.cmd.colorscheme('dracula')
      end
    end,
  },
}
