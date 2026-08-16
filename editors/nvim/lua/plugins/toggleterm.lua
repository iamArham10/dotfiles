return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {

      { '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', desc = 'Float terminal' },
      { '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', desc = 'Horizontal terminal' },
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', desc = 'Vertical terminal' },
    },
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,

        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
        },
      }
    end,
  },
}
