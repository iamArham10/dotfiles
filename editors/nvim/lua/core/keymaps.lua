-- ~/.config/nvim/lua/core/keymaps.lua
-- Key mappings

local keymap = vim.keymap.set

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- General keymaps
keymap('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
keymap('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
keymap('n', '<leader>Q', '<cmd>qa!<CR>', { desc = 'Force quit all' })

-- Clear search highlighting
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Resize windows
keymap('n', '<C-Up>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
keymap('n', '<C-Down>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
keymap('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
keymap('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Buffer navigation
keymap('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
keymap('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
keymap('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
keymap('n', '<leader>bn', '<cmd>enew<CR>', { desc = 'New buffer' })

-- Tab navigation
keymap('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'New tab' })
keymap('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = 'Close tab' })
keymap('n', '<leader>to', '<cmd>tabonly<CR>', { desc = 'Close other tabs' })

-- Move text up and down (Ctrl+Shift+j/k)
keymap('n', '<C-S-j>', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
keymap('n', '<C-S-k>', '<cmd>m .-2<CR>==', { desc = 'Move line up' })
keymap('v', '<C-S-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
keymap('v', '<C-S-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Better indenting
keymap('v', '<', '<gv', { desc = 'Indent left' })
keymap('v', '>', '>gv', { desc = 'Indent right' })

-- Paste without yanking in visual mode
keymap('v', 'p', '"_dP', { desc = 'Paste without yank' })

-- Keep cursor centered when scrolling
keymap('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
keymap('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
keymap('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })

-- Split windows
keymap('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = 'Split vertically' })
keymap('n', '<leader>sh', '<cmd>split<CR>', { desc = 'Split horizontally' })
keymap('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
keymap('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

-- Quick fix list
keymap('n', '<leader>co', '<cmd>copen<CR>', { desc = 'Open quickfix list' })
keymap('n', '<leader>cc', '<cmd>cclose<CR>', { desc = 'Close quickfix list' })
keymap('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous quickfix item' })
keymap('n', ']q', '<cmd>cnext<CR>', { desc = 'Next quickfix item' })

-- Diagnostic keymaps (using vim.diagnostic.jump for Neovim 0.11+)
keymap('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Go to previous diagnostic' })
keymap('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Go to next diagnostic' })
keymap('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
keymap('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', { desc = 'List diagnostics' })

-- Terminal mappings
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
keymap('t', '<C-h>', '<cmd>wincmd h<CR>', { desc = 'Go to left window' })
keymap('t', '<C-j>', '<cmd>wincmd j<CR>', { desc = 'Go to lower window' })
keymap('t', '<C-k>', '<cmd>wincmd k<CR>', { desc = 'Go to upper window' })
keymap('t', '<C-l>', '<cmd>wincmd l<CR>', { desc = 'Go to right window' })

-- Disable arrow keys in normal mode
-- keymap('n', '<Up>', '<Nop>')
-- keymap('n', '<Down>', '<Nop>')
-- keymap('n', '<Left>', '<Nop>')
-- keymap('n', '<Right>', '<Nop>')

-- Better paste
keymap('x', '<leader>p', '"_dP', { desc = 'Paste without overwriting register' })

-- Delete without yanking
keymap({ 'n', 'v' }, '<leader>D', '"_d', { desc = 'Delete without yank' })

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all' })

-- Toggle options
keymap('n', '<leader>uw', '<cmd>set wrap!<CR>', { desc = 'Toggle line wrap' })
keymap('n', '<leader>us', '<cmd>set spell!<CR>', { desc = 'Toggle spell check' })
keymap('n', '<leader>ur', '<cmd>set relativenumber!<CR>', { desc = 'Toggle relative numbers' })

-- Toggle diagnostic virtual text
local diagnostic_virtual_text_enabled = false
keymap('n', '<leader>ud', function()
  diagnostic_virtual_text_enabled = not diagnostic_virtual_text_enabled
  vim.diagnostic.config {
    virtual_text = diagnostic_virtual_text_enabled and {
      prefix = '●',
      source = 'if_many',
    } or false,
  }
  vim.notify('Diagnostic virtual text: ' .. (diagnostic_virtual_text_enabled and 'ON' or 'OFF'))
end, { desc = 'Toggle diagnostic virtual text' })

-- Theme picker (using Telescope)
keymap('n', '<leader>ut', '<cmd>Telescope colorscheme<CR>', { desc = 'Pick colorscheme' })

-- Cycle between default dark, black, and light background
local bg_mode = 'default' -- tracks current state: 'default', 'black', 'light'
keymap('n', '<leader>ub', function()
  if bg_mode == 'default' then
    -- Switch to black background (no background set, already dark)
    bg_mode = 'black'
    local groups = {
      'Normal', 'NormalNC', 'NormalFloat',
      'NvimTreeNormal', 'NvimTreeNormalNC', 'NvimTreeEndOfBuffer',
      'SignColumn', 'EndOfBuffer',
      'StatusLine', 'StatusLineNC',
      'TabLineFill',
    }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = '#181818' })
    end
    vim.notify('Background: black')
  elseif bg_mode == 'black' then
    -- Switch to light
    bg_mode = 'light'
    vim.opt.background = 'light'
    vim.notify('Background: light')
  else
    -- Switch back to default dark
    bg_mode = 'default'
    vim.opt.background = 'dark'
    vim.notify('Background: default')
  end
end, { desc = 'Cycle background: default → black → light' })

-- File path utilities
keymap('n', '<leader>fp', function()
  local path = vim.fn.expand('%:p')
  vim.notify(path, vim.log.levels.INFO, { title = 'File Path' })
end, { desc = 'Show full file path' })

keymap('n', '<leader>fy', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy full file path to clipboard' })

keymap('n', '<leader>fn', function()
  local filename = vim.fn.expand('%:t')
  vim.fn.setreg('+', filename)
  vim.notify('Copied: ' .. filename, vim.log.levels.INFO)
end, { desc = 'Copy filename to clipboard' })

-- User commands for file path
vim.api.nvim_create_user_command('Path', function()
  vim.notify(vim.fn.expand('%:p'), vim.log.levels.INFO)
end, { desc = 'Show full file path' })

vim.api.nvim_create_user_command('CopyPath', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy full file path to clipboard' })
