-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Treesitter configuration for syntax highlighting

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    -- NOTE: New nvim-treesitter (rewrite) explicitly does not support lazy-loading.
    -- It only provides parsers/queries; highlighting is enabled by Neovim via `vim.treesitter.start()`.
    lazy = false,
    config = function()
      -- Ensure the install dir is on runtimepath so Neovim can find parsers/queries.
      -- (The plugin defaults to stdpath('data') .. '/site', but does not prepend it unless configured.)
      require('nvim-treesitter').setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })

      -- Install parsers/queries (async; no-op if already installed).
      require('nvim-treesitter').install({
        'python',
        'lua',
        'vim',
        'vimdoc',
        'javascript',
        'typescript',
        'json',
        'yaml',
        'html',
        'css',
        'bash',
        'markdown',
        'markdown_inline',
      })

      -- Auto-start Tree-sitter highlighting for buffers that have a parser.
      -- This fixes the need to manually run `:lua vim.treesitter.start()` after opening files.
      local group = vim.api.nvim_create_augroup('TreesitterAutoStart', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = '*',
        callback = function(args)
          -- Skip special buffers
          if vim.bo[args.buf].buftype ~= '' then
            return
          end

          -- Avoid re-starting if already active
          if vim.b[args.buf].treesitter_started then
            return
          end

          local ok = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.b[args.buf].treesitter_started = true
          end
        end,
        desc = 'Auto-start Tree-sitter highlighting',
      })

      -- Treesitter highlight links are handled by the colorscheme
    end,
  },

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
    end,
  },
}
