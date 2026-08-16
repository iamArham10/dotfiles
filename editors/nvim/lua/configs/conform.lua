local options = {
  formatters = {
    ['clang-format'] = {
      command = vim.fn.stdpath('data') .. '/mason/bin/clang-format',
      prepend_args = {
        '--style',
        '{BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}',
      },
    },
    ['prettier'] = {
      prepend_args = { '--tab-width', '4' },
    },
    ['google-java-format'] = {
      prepend_args = { '--aosp' },
    },
  },
  formatters_by_ft = {
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    css = { 'prettier' },
    html = { 'prettier' },
    prisma = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    lua = { 'stylua' },
    python = { 'ruff_format' },
    sh = { 'shfmt' },
    java = { 'google-java-format' },
  },
  -- format_on_save = function(bufnr)
  --   local bufname = vim.api.nvim_buf_get_name(bufnr)
  --   local filesize = vim.fn.getfsize(bufname)
  --   if filesize > 200 * 1024 or vim.api.nvim_buf_line_count(bufnr) > 5000 then
  --     return
  --   end
  --   return {
  --     lsp_format = 'fallback',
  --     async = false,
  --     timeout_ms = 1000,
  --   }
  -- end,
}

return options
