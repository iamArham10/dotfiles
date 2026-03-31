return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufReadPre',
  config = function()
    require('treesitter-context').setup {
      enable = true, -- Enable this plugin
      max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 15, -- Minimum editor window height to enable context
      line_numbers = true,
      multiline_threshold = 2, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      separator = nil, -- separater between context and line of code
    }
  end,
}
