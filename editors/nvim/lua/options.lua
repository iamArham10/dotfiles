require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- ── Diagnostic appearance ───────────────────────────────────────────
-- Custom sign icons (Nerd Font)
local signs = {
  [vim.diagnostic.severity.ERROR] = ' ',
  [vim.diagnostic.severity.WARN]  = ' ',
  [vim.diagnostic.severity.INFO]  = ' ',
  [vim.diagnostic.severity.HINT]  = '󰌵 ',
}

vim.diagnostic.config({
  virtual_text = false,  -- off by default; <leader>ud toggles it on
  signs = {
    text = signs,
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
    },
  },
  underline = { severity = { min = vim.diagnostic.severity.HINT } },
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = true,
    border = 'rounded',
    source = true,
    header = '',
    prefix = function(diag)
      local icon = signs[diag.severity] or '● '
      local hl = ({
        [vim.diagnostic.severity.ERROR] = 'DiagnosticFloatingError',
        [vim.diagnostic.severity.WARN]  = 'DiagnosticFloatingWarn',
        [vim.diagnostic.severity.INFO]  = 'DiagnosticFloatingInfo',
        [vim.diagnostic.severity.HINT]  = 'DiagnosticFloatingHint',
      })[diag.severity] or 'DiagnosticFloatingHint'
      return icon, hl
    end,
  },
})

-- Treesitter-based code folding (expr folding)
local opt = vim.opt
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldtext = ''  -- Use default fold text
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Set global indentation to 4 spaces
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.softtabstop = 4

-- Enable relative line numbers
opt.relativenumber = true

-- Keep cursor away from edges
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Disable unused built-in Vim plugins for faster startup
local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end
