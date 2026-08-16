return {
  -- Treesitter textobjects (vaf, vaa, etc.)
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function()
      -- Configure selection behavior (same as VSCode setup)
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

      local select = require('nvim-treesitter-textobjects.select')

      -- Preserve standard mappings (af/if/ac/ic/aa/ia) for operator/visual mode.
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        select.select_textobject('@function.outer')
      end, { desc = 'Select outer function' })
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        select.select_textobject('@function.inner')
      end, { desc = 'Select inner function' })
      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        select.select_textobject('@class.outer')
      end, { desc = 'Select outer class' })
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        select.select_textobject('@class.inner')
      end, { desc = 'Select inner class' })
      vim.keymap.set({ 'x', 'o' }, 'aa', function()
        select.select_textobject('@parameter.outer')
      end, { desc = 'Select outer parameter/argument' })
      vim.keymap.set({ 'x', 'o' }, 'ia', function()
        select.select_textobject('@parameter.inner')
      end, { desc = 'Select inner parameter/argument' })

      -- Convenience mappings: vaf / vaa directly start visual selection.
      vim.keymap.set('n', 'vaf', function()
        select.select_textobject('@function.outer')
      end, { desc = 'Visual around function' })
      vim.keymap.set('n', 'vaa', function()
        select.select_textobject('@parameter.outer')
      end, { desc = 'Visual around parameter/argument' })
      vim.keymap.set('n', 'vac', function()
        select.select_textobject('@class.outer')
      end, { desc = 'Visual around class' })

      -- ── Move: jump between functions / classes ──────────────────────
      local move = require('nvim-treesitter-textobjects.move')

      -- Next / previous function start
      vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
        move.goto_next_start('@function.outer')
      end, { desc = 'Next function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
        move.goto_previous_start('@function.outer')
      end, { desc = 'Previous function start' })

      -- Next / previous function end
      vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
        move.goto_next_end('@function.outer')
      end, { desc = 'Next function end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
        move.goto_previous_end('@function.outer')
      end, { desc = 'Previous function end' })

      -- Next / previous class start
      vim.keymap.set({ 'n', 'x', 'o' }, ']c', function()
        move.goto_next_start('@class.outer')
      end, { desc = 'Next class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[c', function()
        move.goto_previous_start('@class.outer')
      end, { desc = 'Previous class start' })
    end,
  },
}
