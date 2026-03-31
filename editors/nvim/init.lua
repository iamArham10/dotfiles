-- ~/.config/nvim/init.lua
-- Conditional loading for Neovim vs VSCode-Neovim

-- lazy.nvim plugin manager (needed for both environments)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
  -- ════════════════════════════════════════════════════════════════════
  -- VSCode-Neovim: Minimal config, VSCode handles most features
  -- ════════════════════════════════════════════════════════════════════

  -- Minimal options
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.opt.clipboard = 'unnamedplus'
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  -- Load VSCode-specific keymaps
  require('core.keymaps-vscode')

  -- Load only VSCode-compatible plugins
  require('lazy').setup({
    { import = 'plugins.vscode' },
  }, {
    change_detection = { notify = false },
    performance = {
      rtp = {
        disabled_plugins = {
          'netrw', 'netrwPlugin', 'gzip', 'zip', 'zipPlugin',
          'tar', 'tarPlugin', 'tohtml', 'tutor',
        },
      },
    },
  })

else
  -- ════════════════════════════════════════════════════════════════════
  -- Pure Neovim: Full configuration
  -- ════════════════════════════════════════════════════════════════════

  require('core.options')
  require('core.keymaps')

  -- Load all plugins
  require('lazy').setup('plugins', {
    change_detection = {
      notify = false,
    },
  })

  -- Load autocmds last
  require('core.autocmds')
end
