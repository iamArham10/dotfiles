-- ~/.config/nvim/lua/plugins/illuminate.lua
-- Automatically highlights all occurrences of the word under cursor
return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('illuminate').configure({
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
      filetypes_denylist = {
        'NvimTree',
        'Trouble',
        'alpha',
        'lazy',
        'mason',
        'toggleterm',
        'TelescopePrompt',
      },
    })
  end,
}
