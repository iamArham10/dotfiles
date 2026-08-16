local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults() -- Loads NvChad's default mappings
local capabilities = nvlsp.capabilities

-- Set up LSP keymaps on attach (User's custom overrides)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(event)
    local buf = event.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, noremap = true, silent = true, desc = desc })
    end

    map('n', 'gR', '<cmd>Telescope lsp_references<CR>', 'Show LSP references')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', 'Show LSP definitions')
    map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', 'Show LSP implementations')
    map('n', 'gy', '<cmd>Telescope lsp_type_definitions<CR>', 'Show LSP type definitions')
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'See available code actions')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'Smart rename')
    map('n', '<leader>xb', '<cmd>Telescope diagnostics bufnr=0<CR>', 'Show buffer diagnostics')
    map('n', 'K', function()
      vim.lsp.buf.hover({ border = 'rounded', max_width = 60, max_height = 20 })
    end, 'Show documentation for cursor')
    map('n', '<leader>rs', '<cmd>LspRestart<CR>', 'Restart LSP')
  end,
})

-- Native Neovim 0.11 LSP configuration API
-- Default config for all servers
vim.lsp.config('*', {
  capabilities = capabilities,
  root_markers = { '.git', 'pyproject.toml', 'setup.py', 'requirements.txt' },
})

-- Server-specific configurations
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

vim.lsp.config('ty', {
  settings = {
    ty = {
      completions = { autoImport = true },
      diagnosticMode = 'openFilesOnly', 
    },
  },
})

vim.lsp.config('ruff', {
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
  end,
})

vim.lsp.config('ts_ls', {
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
      },
    },
  },
})

vim.lsp.config('clangd', {
  root_markers = {
    'compile_commands.json',
    'compile_flags.txt',
    '.clangd',
    'CMakeLists.txt',
    'Makefile',
    'meson.build',
    '.git',
  },
  cmd = {
    vim.fn.stdpath('data') .. '/mason/bin/clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--header-insertion=iwyu',
  },
})

vim.lsp.config('eslint', {
  root_markers = { 'eslint.config.js', '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', '.eslintrc.yaml', '.eslintrc.yml', 'package.json', '.git' },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

vim.lsp.config('tailwindcss', {
  root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.cjs', 'tailwind.config.mjs', 'postcss.config.js', 'package.json' },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { 'class:\\s*"([^"]*)"' },
          { 'className\\s*=\\s*"([^"]*)"' },
          { 'cn\\(([^)]*)\\)', '["\'`]([^"\'`]*)["\'`]' },
          { 'clsx\\(([^)]*)\\)', '["\'`]([^"\'`]*)["\'`]' },
          { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*)["\'`]' },
          { 'twMerge\\(([^)]*)\\)', '["\'`]([^"\'`]*)["\'`]' },
        },
      },
    },
  },
})

vim.lsp.config('prismals', {
  root_markers = { 'schema.prisma', 'package.json', '.git' },
})

vim.lsp.config('emmet_language_server', {
  filetypes = { 'html', 'htmldjango', 'css', 'scss', 'less', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
})

-- Enable all servers 
vim.lsp.enable {
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
}
