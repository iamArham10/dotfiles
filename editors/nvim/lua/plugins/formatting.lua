-- ~/.config/nvim/lua/plugins/formatting.lua
return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        lua = { 'stylua' },
        python = { 'ruff_format', 'black', stop_after_first = true },
        sh = { 'shfmt' },
      },
      format_on_save = {
        lsp_format = 'fallback',
        async = false,  -- Sync to avoid BufWritePre errors
        timeout_ms = 1000,
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
      conform.format {
        lsp_format = 'fallback',
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = 'Format file or range' })

    -- Telescope-based formatter picker
    vim.keymap.set('n', '<leader>mf', function()
      local formatters = conform.list_formatters_for_buffer()
      table.insert(formatters, { name = 'LSP', available = true })

      require('telescope.pickers').new({}, {
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
      }):find()
    end, { desc = 'Choose formatter' })
  end,
}
