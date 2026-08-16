return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function(_, opts)
    local telescope = require("telescope")

    -- Add the ui-select extension configuration to the existing opts
    opts.extensions = opts.extensions or {}
    opts.extensions["ui-select"] = {
      require("telescope.themes").get_dropdown()
    }

    -- Run the standard NvChad telescope setup
    telescope.setup(opts)

    -- Load the extensions
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
}
