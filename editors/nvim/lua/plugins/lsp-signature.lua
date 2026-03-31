-- ~/.config/nvim/lua/plugins/lsp-signature.lua
-- Shows function signature hints as you type parameters
return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {
    bind = true, -- This is mandatory, otherwise border config won't work
    handler_opts = {
      border = 'rounded'
    },
    hint_enable = true, -- Virtual hint enable
    hint_prefix = '🐼 ', -- Panda for parameter hint
    hi_parameter = 'LspSignatureActiveParameter', -- Highlight group for current parameter
    floating_window = true, -- Show hint in a floating window
    floating_window_above_cur_line = true, -- Try to place the floating above the current line
    toggle_key = '<C-k>', -- Toggle signature on/off with Ctrl-k
    select_signature_key = '<C-n>', -- Cycle to next signature (if function has overloads)
  },
  config = function(_, opts)
    require('lsp_signature').setup(opts)
  end
}
