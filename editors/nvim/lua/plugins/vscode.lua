-- ~/.config/nvim/lua/plugins/vscode.lua
-- Plugins that work with vscode-neovim extension
-- These enhance vim motions without conflicting with VSCode features

-- IMPORTANT:
-- In normal Neovim, `lazy.setup('plugins', ...)` loads every module under `lua/plugins/`.
-- This file contains VSCode-only variants (including a minimal Treesitter config that
-- intentionally does NOT enable highlighting). If it loads in normal Neovim it can
-- override the real Treesitter setup and break automatic highlighting.
if not vim.g.vscode then
  return {}
end

return {
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
        { '<leader>r', group = 'Rename' },
      })
    end,
  },

  -- Surround selections (cs, ds, ys)
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end,
  },

  -- Comment toggling (gcc, gc{motion})
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
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

  -- Better escape from insert mode (jk, jj)
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

  -- Enhanced text objects (af, if, ac, ic, etc.)
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function()
      -- Note: Treesitter itself is handled by VSCode, but textobjects still work
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = 'V',
          },
        },
      })

      -- Textobjects: select
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.outer')
      end, { desc = 'Select outer function' })
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.inner')
      end, { desc = 'Select inner function' })
      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@class.outer')
      end, { desc = 'Select outer class' })
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@class.inner')
      end, { desc = 'Select inner class' })
      vim.keymap.set({ 'x', 'o' }, 'aa', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@parameter.outer')
      end, { desc = 'Select outer parameter' })
      vim.keymap.set({ 'x', 'o' }, 'ia', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@parameter.inner')
      end, { desc = 'Select inner parameter' })

      -- Textobjects: move
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer')
      end, { desc = 'Next function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer')
      end, { desc = 'Next class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer')
      end, { desc = 'Previous function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer')
      end, { desc = 'Previous class start' })
    end,
  },

  -- Treesitter (needed for textobjects to work)
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      -- Minimal setup - VSCode handles syntax highlighting
      -- We just need parsers for textobjects
      local ts = require('nvim-treesitter')
      ts.install({
        'lua', 'vim', 'vimdoc', 'query', 'python', 'javascript', 'typescript',
        'tsx', 'json', 'yaml', 'html', 'css', 'bash', 'markdown',
        'markdown_inline', 'regex', 'c', 'cpp', 'rust', 'go', 'latex', 'bibtex',
      })
      -- Don't enable treesitter highlighting in VSCode
    end,
  },
}
