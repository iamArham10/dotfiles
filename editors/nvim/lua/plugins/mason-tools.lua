return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'ty',
          'ruff',
          'ts_ls',
          'eslint',
          'prismals',
          'rust_analyzer',
          'clangd',
          'bashls',
          'jsonls',
          'yamlls',
          'html',
          'cssls',
          'tailwindcss',
          'emmet_language_server',
          'jdtls',
        },
        automatic_installation = true,
      }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'clang-format',
          'prettier',
          'stylua',
          'ruff',
          'shfmt',
          'latexindent',
          'google-java-format',
        },
        run_on_start = true,
        auto_update = false,
      }
    end,
  },
}
