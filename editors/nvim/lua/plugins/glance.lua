return {
  "dnlhc/glance.nvim",
  event = "LspAttach",
  cmd = "Glance",
  keys = {
    { "gp", "<cmd>Glance definitions<CR>", desc = "Glance definitions" },
    { "gP", "<cmd>Glance references<CR>", desc = "Glance references" },
    { "gI", "<cmd>Glance implementations<CR>", desc = "Glance implementations" },
    { "gT", "<cmd>Glance type_definitions<CR>", desc = "Glance type definitions" },
  },
  config = function()
    local actions = require("glance").actions

    require("glance").setup({
      border = {
        enable = true,
      },
      mappings = {
        list = {
          ["<Tab>"] = actions.enter_win("preview"), -- Focus preview (left pane)
          ["<C-n>"] = actions.next_location,         -- Next location
          ["<C-p>"] = actions.previous_location,     -- Previous location
        },
        preview = {
          ["<Tab>"] = actions.enter_win("list"),     -- Focus list (right pane)
          ["<C-n>"] = actions.next_location,         -- Next location
          ["<C-p>"] = actions.previous_location,     -- Previous location
        },
      },
    })
  end,
}
