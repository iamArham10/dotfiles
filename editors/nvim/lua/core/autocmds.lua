-- ~/.config/nvim/lua/core/autocmds.lua
-- Auto commands

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General settings group
local general = augroup('General', { clear = true })

-- Highlight yanked text
autocmd('TextYankPost', {
  group = general,
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
  desc = 'Highlight yanked text',
})

-- Remove trailing whitespace on save
autocmd('BufWritePre', {
  group = general,
  pattern = '*',
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == 'markdown' or ft == 'text' or ft == 'gitcommit' then
      return
    end
    local save_cursor = vim.fn.getpos '.'
    vim.cmd [[%s/\s\+$//e]]
    vim.fn.setpos('.', save_cursor)
  end,
  desc = 'Remove trailing whitespace',
})

-- Auto create directories when saving
autocmd('BufWritePre', {
  group = general,
  callback = function(event)
    if event.match:match '^%w%w+://' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
  desc = 'Auto create directories',
})

-- Resize splits when window is resized
autocmd('VimResized', {
  group = general,
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
  desc = 'Resize splits on window resize',
})

-- Close some filetypes with 'q'
autocmd('FileType', {
  group = general,
  pattern = {
    'qf',
    'help',
    'man',
    'notify',
    'lspinfo',
    'startuptime',
    'checkhealth',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
  end,
  desc = 'Close with q',
})

-- Set wrap and spell for text filetypes
autocmd('FileType', {
  group = general,
  pattern = { 'gitcommit', 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = 'Enable wrap and spell for text files',
})

-- Set 2-space indentation for web languages
autocmd('FileType', {
  group = general,
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'css', 'scss', 'json', 'yaml', 'lua' },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = 'Use 2 spaces for web languages',
})

-- Don't auto comment new lines
autocmd('BufEnter', {
  group = general,
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
  desc = 'Disable auto comment',
})

-- Go to last location when opening buffer
autocmd('BufReadPost', {
  group = general,
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = 'Go to last location',
})

-- Show cursor line only in active window
local cursorline = augroup('CursorLine', { clear = true })
autocmd({ 'InsertLeave', 'WinEnter' }, {
  group = cursorline,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
  desc = 'Show cursorline',
})

autocmd({ 'InsertEnter', 'WinLeave' }, {
  group = cursorline,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
  desc = 'Hide cursorline',
})


-- Open nvim-tree when opening a directory
local open_nvim_tree = augroup('OpenNvimTree', { clear = true })
autocmd('VimEnter', {
  group = open_nvim_tree,
  callback = function(data)
    -- Check if the argument is a directory
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
      return
    end
    -- Change to that directory
    vim.cmd.cd(data.file)
    -- Open nvim-tree
    require('nvim-tree.api').tree.open()
  end,
  desc = 'Open nvim-tree on directory',
})

-- Terminal settings
local terminal = augroup('Terminal', { clear = true })
autocmd('TermOpen', {
  group = terminal,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
  end,
  desc = 'Terminal options',
})

-- Note: Treesitter highlighting is handled by nvim-treesitter plugin with highlight.enable = true
-- No need for manual autocmd here
