require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

-- Remove NvChad's built-in terminal mappings (replaced by toggleterm)
nomap("t", "<C-x>")
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap({ "n", "t" }, "<A-v>")
nomap({ "n", "t" }, "<A-h>")
nomap({ "n", "t" }, "<A-i>")

-- Terminal mode mappings (for toggleterm)
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-h>', '<cmd>wincmd h<CR>', { desc = 'Go to left window' })
map('t', '<C-j>', '<cmd>wincmd j<CR>', { desc = 'Go to lower window' })
map('t', '<C-k>', '<cmd>wincmd k<CR>', { desc = 'Go to upper window' })
map('t', '<C-l>', '<cmd>wincmd l<CR>', { desc = 'Go to right window' })

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map('n', '<leader>U', function()
  vim.cmd.packadd('nvim.undotree')
  require('undotree').open()
end, { desc = 'Undo tree' })

-- Helper function to close buffer without losing window layout or file explorer
local function close_buffer(force)
  local current = vim.api.nvim_get_current_buf()
  local force_str = force and "!" or ""

  if not force and vim.api.nvim_get_option_value('modified', { buf = current }) then
    vim.notify("No write since last change (use force delete to override)", vim.log.levels.ERROR)
    return
  end

  local listed = vim.fn.getbufinfo({buflisted = 1})
  if #listed > 1 then
    vim.cmd('bprevious')
  else
    vim.cmd('enew')
  end
  vim.cmd('bdelete' .. force_str .. ' ' .. current)
end

-- Buffer navigation
map('n', '<leader>bb', '<cmd>Telescope buffers<CR>', { desc = 'Find buffer' })

map('n', '<leader>bd', function() require('nvchad.tabufline').close_buffer() end, { desc = 'Close current buffer' })
map('n', '<leader>bD', function() require('nvchad.tabufline').closeOtherBufs() end, { desc = 'Delete all other buffers' })
map('n', '<leader>ba', function() require('nvchad.tabufline').closeAllBufs() end, { desc = 'Delete all buffers' })

map('n', '<leader>bt', function()
  if vim.o.showtabline == 0 then
    vim.o.showtabline = 2
  else
    vim.o.showtabline = 0
  end
end, { desc = 'Toggle bufferline' })

map('n', '<leader>bx', function() close_buffer(true) end, { desc = 'Force delete buffer' })
map('n', '<leader>bw', '<cmd>w<CR><cmd>lua require("nvchad.tabufline").close_buffer()<CR>', { desc = 'Save and close buffer' })
map('n', '<leader>bl', '<cmd>ls<CR>', { desc = 'List buffers' })
map('n', '<leader>bp', function() require('nvchad.tabufline').prev() end, { desc = 'Previous buffer' })
map('n', '<leader>bN', function() require('nvchad.tabufline').next() end, { desc = 'Next buffer' })

map('n', '<S-h>', function() require('nvchad.tabufline').prev() end, { desc = 'Focus previous buffer' })
map('n', '<S-l>', function() require('nvchad.tabufline').next() end, { desc = 'Focus next buffer' })
map('n', '<A-,>', function() require('nvchad.tabufline').move_buf(-1) end, { desc = 'Move buffer left' })
map('n', '<A-.>', function() require('nvchad.tabufline').move_buf(1) end, { desc = 'Move buffer right' })

for i = 1, 9, 1 do
  map('n', string.format('<leader>%s', i), function()
    local bufs = vim.t.bufs
    if bufs and bufs[i] then
      vim.api.nvim_set_current_buf(bufs[i])
    end
  end, { desc = string.format('Go to buffer %s', i) })
end

-- Tab navigation
map('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'New tab' })
map('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = 'Close tab' })
map('n', '<leader>to', '<cmd>tabonly<CR>', { desc = 'Close other tabs' })

-- File Explorer
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })

-- Split windows
map('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = 'Split vertically' })
map('n', '<leader>sh', '<cmd>split<CR>', { desc = 'Split horizontally' })
map('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
map('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

-- Resize windows
map('n', '<C-Up>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Down>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Save and format
map('n', '<leader>w', function()
  require('conform').format { lsp_format = 'fallback', async = false, timeout_ms = 1000 }
  vim.cmd('w')
end, { desc = 'Format and save file' })

-- Save without formatting
map('n', '<leader>W', '<cmd>noautocmd w<CR>', { desc = 'Save file (no formatter)' })

-- General Toggles & Utilities
map('n', '<leader>uw', '<cmd>set wrap!<CR>', { desc = 'Toggle line wrap' })
map('n', '<leader>us', '<cmd>set spell!<CR>', { desc = 'Toggle spell check' })
map('n', '<leader>sa', 'gg<S-v>G', { desc = 'Select all' })
map('n', '<leader>Q', '<cmd>qa!<CR>', { desc = 'Force quit all' })

-- File path utilities
map('n', '<leader>fp', function()
  local path = vim.fn.expand('%:p')
  vim.notify(path, vim.log.levels.INFO, { title = 'File Path' })
end, { desc = 'Show full file path' })

map('n', '<leader>fy', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy full file path to clipboard' })

map('n', '<leader>fn', function()
  local filename = vim.fn.expand('%:t')
  vim.fn.setreg('+', filename)
  vim.notify('Copied: ' .. filename, vim.log.levels.INFO)
end, { desc = 'Copy filename to clipboard' })

-- Diagnostics
map('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Go to previous diagnostic' })

map('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Go to next diagnostic' })

map('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
map('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', { desc = 'List diagnostics' })

local diag_mode = 0 -- 0 = off, 1 = virtual_text, 2 = virtual_lines
local diag_icons = { ' ', ' ', ' ', '󰌵 ' }
local diag_labels = { 'OFF', 'Virtual Text', 'Virtual Lines' }

map('n', '<leader>ud', function()
  diag_mode = (diag_mode + 1) % 3

  if diag_mode == 0 then
    -- All inline display off
    vim.diagnostic.config({ virtual_text = false, virtual_lines = false })
  elseif diag_mode == 1 then
    -- Compact inline virtual text
    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = {
        spacing = 4,
        prefix = function(diag)
          return diag_icons[diag.severity] or '●'
        end,
        format = function(diag)
          local src = diag.source and ('[' .. diag.source:gsub('%.$', '') .. '] ') or ''
          return src .. diag.message:gsub('\n', ' ')
        end,
      },
    })
  else
    -- Full virtual lines (Neovim 0.11+)
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = { current_line = true },
    })
  end

  vim.notify('Diagnostics: ' .. diag_labels[diag_mode + 1], vim.log.levels.INFO)
end, { desc = 'Cycle diagnostic display (off/text/lines)' })

-- Formatting
map({ 'n', 'v' }, '<leader>mp', function()
  require('conform').format {
    lsp_format = 'fallback',
    async = false,
    timeout_ms = 1000,
  }
end, { desc = 'Format file or range' })

map('n', '<leader>mf', function()
  local conform = require('conform')
  local formatters = conform.list_formatters_for_buffer()
  table.insert(formatters, { name = 'LSP', available = true })

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Select Formatter',
      finder = require('telescope.finders').new_table {
        results = formatters,
        entry_maker = function(formatter)
          local name = type(formatter) == 'string' and formatter or formatter.name
          return { value = name, display = name, ordinal = name }
        end,
      },
      sorter = require('telescope.config').values.generic_sorter {},
      attach_mappings = function(prompt_bufnr)
        require('telescope.actions').select_default:replace(function()
          require('telescope.actions').close(prompt_bufnr)
          local selection = require('telescope.actions.state').get_selected_entry()
          if selection.value == 'LSP' then
            vim.lsp.buf.format { async = false }
          else
            conform.format { formatters = { selection.value }, async = false }
          end
        end)
        return true
      end,
    })
    :find()
end, { desc = 'Choose formatter' })
