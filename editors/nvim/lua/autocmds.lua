require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General settings group
local general = augroup('CustomGeneral', { clear = true })

-- Highlight yanked text
autocmd('TextYankPost', {
  group = general,
  callback = function()
    vim.hl.on_yank { higroup = 'IncSearch', timeout = 200 }
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

-- Show cursor line only in active window
local cursorline = augroup('CustomCursorLine', { clear = true })
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

-- Force relative line numbers for normal buffers (fixes startup bugs)
autocmd('BufWinEnter', {
  group = general,
  callback = function()
    local ft = vim.bo.filetype
    if vim.bo.buftype == '' and ft ~= 'alpha' and ft ~= 'NvimTree' then
      vim.opt_local.relativenumber = true
    end
  end,
  desc = 'Force relative line numbers',
})
