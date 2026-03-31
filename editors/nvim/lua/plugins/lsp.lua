-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUpdate' },
    build = ':MasonUpdate',
    config = function()
      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'pyright',
          'ruff',
          'ts_ls',
          'rust_analyzer',
          'clangd',
          'bashls',
          'jsonls',
          'yamlls',
          'html',
          'cssls',
          'emmet_language_server',
        },
        automatic_installation = true,
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      { 'antosha417/nvim-lsp-file-operations', config = true },
      { 'folke/lazydev.nvim', ft = 'lua', opts = {} },
    },
    config = function()
      local cmp_nvim_lsp = require 'cmp_nvim_lsp'

      -- Capabilities for autocompletion
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Set up LSP keymaps on attach
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
          map('n', 'K', vim.lsp.buf.hover, 'Show documentation for cursor')
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
      -- Note: lazydev.nvim handles workspace library and vim global for lua_ls
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })

      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnusedVariable = 'none',
                reportUnusedImport = 'none',
                reportUnusedClass = 'none',
                reportUnusedFunction = 'none',
              },
            },
          },
        },
      })

      -- Ruff LSP: linting only, disable hover (let Pyright handle it)
      vim.lsp.config('ruff', {
        on_attach = function(client, bufnr)
          -- Disable hover in favor of Pyright
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

      -- Emmet language server: emmet completions via LSP (shows in nvim-cmp)
      vim.lsp.config('emmet_language_server', {
        filetypes = { 'html', 'htmldjango', 'css', 'scss', 'less', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
      })

      -- Enable all servers (nvim-lspconfig provides default cmd/filetypes)
      vim.lsp.enable {
        'lua_ls',
        'pyright',
        'ruff', -- Linting for Python
        'ts_ls',
        'rust_analyzer',
        'clangd',
        'bashls',
        'jsonls',
        'yamlls',
        'html',
        'cssls',
        'emmet_language_server',
      }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'prettier',
          'stylua',
          'ruff',
          'black',
          'eslint_d',
          'shfmt',
          'latexindent',
        },
        run_on_start = true,
        auto_update = false,
      }
    end,
  },
}
