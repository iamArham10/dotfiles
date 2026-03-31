-- ~/.config/nvim/lua/core/options.lua
-- Core editor settings

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false
opt.linebreak = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'
opt.cursorline = true
-- Use default cursor (block in normal, thin bar in insert)
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Behavior
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.undofile = true
opt.undolevels = 10000
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = 'menu,menuone,noselect'
opt.pumheight = 10

-- File encoding
opt.fileencoding = 'utf-8'

-- Session options (for auto-session)
opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Diagnostic configuration (all diagnostic settings consolidated here)
vim.diagnostic.config {
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = '󰠠 ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
    max_width = 80,
    wrap = true,
  },
}



-- Backspace behavior
opt.backspace = 'indent,eol,start'

-- Command line
opt.showcmd = true
opt.cmdheight = 1

-- Status line
opt.laststatus = 3 -- Global statusline

-- Folding (native treesitter-based for Neovim 0.10+)
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldtext = ''  -- Use default fold text
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Wildmenu
opt.wildmode = 'longest:full,full'
opt.wildignore = '*.o,*.obj,*.dylib,*.bin,*.dll,*.exe,*.git,*.svn'

-- Disable some built-in plugins
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
