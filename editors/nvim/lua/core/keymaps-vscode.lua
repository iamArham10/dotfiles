-- ~/.config/nvim/lua/core/keymaps-vscode.lua
-- VSCode-specific keymaps using VSCodeNotify

local keymap = vim.keymap.set

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Helper function for VSCode commands
local function vscode(cmd)
  return function()
    vim.fn.VSCodeNotify(cmd)
  end
end

-- ══════════════════════════════════════════════════════════════════════
-- FILE OPERATIONS
-- ══════════════════════════════════════════════════════════════════════
keymap('n', '<leader>w', vscode('workbench.action.files.save'), { desc = 'Save file' })
keymap('n', '<leader>q', vscode('workbench.action.closeActiveEditor'), { desc = 'Close editor' })
keymap('n', '<leader>Q', vscode('workbench.action.closeAllEditors'), { desc = 'Close all editors' })

-- ══════════════════════════════════════════════════════════════════════
-- FIND / SEARCH (replaces Telescope)
-- ══════════════════════════════════════════════════════════════════════
keymap('n', '<leader>ff', vscode('workbench.action.quickOpen'), { desc = 'Find files' })
keymap('n', '<leader>fg', vscode('workbench.action.findInFiles'), { desc = 'Find in files (grep)' })
keymap('n', '<leader>fb', vscode('workbench.action.showAllEditors'), { desc = 'Find buffers' })
keymap('n', '<leader>fh', vscode('workbench.action.showCommands'), { desc = 'Command palette' })
keymap('n', '<leader>fr', vscode('workbench.action.openRecent'), { desc = 'Recent files' })
keymap('n', '<leader>fc', vscode('editor.action.addSelectionToNextFindMatch'), { desc = 'Find word under cursor' })
keymap('n', '<leader>fs', vscode('workbench.action.gotoSymbol'), { desc = 'Go to symbol' })

-- ══════════════════════════════════════════════════════════════════════
-- FILE EXPLORER
-- ══════════════════════════════════════════════════════════════════════
keymap('n', '<leader>e', vscode('workbench.action.toggleSidebarVisibility'), { desc = 'Toggle sidebar' })
keymap('n', '<leader>ef', vscode('workbench.files.action.showActiveFileInExplorer'), { desc = 'Show file in explorer' })

-- ══════════════════════════════════════════════════════════════════════
-- LSP / CODE ACTIONS
-- ══════════════════════════════════════════════════════════════════════
keymap('n', 'gd', vscode('editor.action.revealDefinition'), { desc = 'Go to definition' })
keymap('n', 'gD', vscode('editor.action.revealDeclaration'), { desc = 'Go to declaration' })
keymap('n', 'gR', vscode('editor.action.goToReferences'), { desc = 'Go to references' })
keymap('n', 'gi', vscode('editor.action.goToImplementation'), { desc = 'Go to implementation' })
keymap('n', 'gt', vscode('editor.action.goToTypeDefinition'), { desc = 'Go to type definition' })
keymap('n', 'K', vscode('editor.action.showHover'), { desc = 'Hover documentation' })
keymap({ 'n', 'v' }, '<leader>ca', vscode('editor.action.quickFix'), { desc = 'Code action' })
keymap('n', '<leader>rn', vscode('editor.action.rename'), { desc = 'Rename symbol' })
keymap('n', '<leader>cf', vscode('editor.action.formatDocument'), { desc = 'Format document' })
keymap('v', '<leader>cf', vscode('editor.action.formatSelection'), { desc = 'Format selection' })

-- ══════════════════════════════════════════════════════════════════════
-- DIAGNOSTICS
-- ══════════════════════════════════════════════════════════════════════
keymap('n', '[d', vscode('editor.action.marker.prev'), { desc = 'Previous diagnostic' })
keymap('n', ']d', vscode('editor.action.marker.next'), { desc = 'Next diagnostic' })
keymap('n', '<leader>d', vscode('editor.action.showHover'), { desc = 'Show diagnostic' })
keymap('n', '<leader>dl', vscode('workbench.actions.view.problems'), { desc = 'Problems panel' })

-- ══════════════════════════════════════════════════════════════════════
-- WINDOW / EDITOR NAVIGATION
-- ══════════════════════════════════════════════════════════════════════
keymap('n', '<C-h>', vscode('workbench.action.focusLeftGroup'), { desc = 'Focus left group' })
keymap('n', '<C-j>', vscode('workbench.action.focusBelowGroup'), { desc = 'Focus below group' })
keymap('n', '<C-k>', vscode('workbench.action.focusAboveGroup'), { desc = 'Focus above group' })
keymap('n', '<C-l>', vscode('workbench.action.focusRightGroup'), { desc = 'Focus right group' })

-- Split management
keymap('n', '<leader>sv', vscode('workbench.action.splitEditorRight'), { desc = 'Split right' })
keymap('n', '<leader>sh', vscode('workbench.action.splitEditorDown'), { desc = 'Split down' })
keymap('n', '<leader>sx', vscode('workbench.action.closeActiveEditor'), { desc = 'Close split' })

-- ══════════════════════════════════════════════════════════════════════
-- BUFFER / TAB NAVIGATION
-- ══════════════════════════════════════════════════════════════════════
keymap('n', '<S-l>', vscode('workbench.action.nextEditor'), { desc = 'Next editor' })
keymap('n', '<S-h>', vscode('workbench.action.previousEditor'), { desc = 'Previous editor' })
keymap('n', '<leader>bd', vscode('workbench.action.closeActiveEditor'), { desc = 'Close buffer' })

-- ══════════════════════════════════════════════════════════════════════
-- GIT
-- ══════════════════════════════════════════════════════════════════════
keymap('n', '<leader>gs', vscode('workbench.view.scm'), { desc = 'Git status (SCM)' })
keymap('n', '<leader>gb', vscode('gitlens.toggleFileBlame'), { desc = 'Git blame' })
keymap('n', ']h', vscode('workbench.action.editor.nextChange'), { desc = 'Next git change' })
keymap('n', '[h', vscode('workbench.action.editor.previousChange'), { desc = 'Previous git change' })

-- ══════════════════════════════════════════════════════════════════════
-- UI TOGGLES
-- ══════════════════════════════════════════════════════════════════════
keymap('n', '<leader>z', vscode('workbench.action.toggleZenMode'), { desc = 'Toggle Zen mode' })
keymap('n', '<leader>uw', vscode('editor.action.toggleWordWrap'), { desc = 'Toggle word wrap' })

-- ══════════════════════════════════════════════════════════════════════
-- TERMINAL
-- ══════════════════════════════════════════════════════════════════════
keymap('n', '<C-\\>', vscode('workbench.action.terminal.toggleTerminal'), { desc = 'Toggle terminal' })
keymap('n', '<leader>tf', vscode('workbench.action.terminal.toggleTerminal'), { desc = 'Toggle terminal' })

-- ══════════════════════════════════════════════════════════════════════
-- FOLDING
-- ══════════════════════════════════════════════════════════════════════
keymap('n', 'za', vscode('editor.toggleFold'), { desc = 'Toggle fold' })
keymap('n', 'zR', vscode('editor.unfoldAll'), { desc = 'Unfold all' })
keymap('n', 'zM', vscode('editor.foldAll'), { desc = 'Fold all' })

-- ══════════════════════════════════════════════════════════════════════
-- PURE VIM KEYMAPS (work identically in both)
-- ══════════════════════════════════════════════════════════════════════

-- Clear search highlighting
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Move text up and down
keymap('n', '<A-j>', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
keymap('n', '<A-k>', '<cmd>m .-2<CR>==', { desc = 'Move line up' })
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

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

-- Better paste
keymap('x', '<leader>p', '"_dP', { desc = 'Paste without overwriting register' })

-- Delete without yanking
keymap({ 'n', 'v' }, '<leader>D', '"_d', { desc = 'Delete without yank' })

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all' })
