return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      javascript = {},
      typescript = {},
      javascriptreact = {},
      typescriptreact = {},
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        if vim.b[bufnr].lint_timer then
          vim.fn.timer_stop(vim.b[bufnr].lint_timer)
        end

        vim.b[bufnr].lint_timer = vim.fn.timer_start(100, function()
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(bufnr) then
              lint.try_lint()
              vim.b[bufnr].lint_timer = nil
            end
          end)
        end)
      end,
    })

    vim.keymap.set('n', '<leader>ll', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end,
}
