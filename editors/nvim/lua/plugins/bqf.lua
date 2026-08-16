return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  config = function()
    require("bqf").setup({
      auto_resize_height = true,
      preview = {
        auto_preview = true,
        border = "rounded",
        winblend = 0,
      },
    })
  end,
}
