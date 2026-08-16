-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

local is_neovide = vim.g.neovide and true or false

M.base46 = {
	theme = "chadracula",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
		Keyword = { bold = is_neovide },
		Function = { bold = is_neovide },
		Statement = { bold = is_neovide },
		Conditional = { bold = is_neovide },
		Repeat = { bold = is_neovide },
		["@keyword"] = { bold = is_neovide },
		["@function"] = { bold = is_neovide },
		["@function.builtin"] = { bold = is_neovide },
		["@function.call"] = { bold = is_neovide },

		-- Diagnostic signs: bold icons in the gutter
		DiagnosticSignError = { bold = is_neovide },
		DiagnosticSignWarn = { bold = is_neovide },
		DiagnosticSignInfo = { bold = is_neovide },
		DiagnosticSignHint = { bold = is_neovide },

		-- Diagnostic virtual text: italic so it's distinct from real code
		DiagnosticVirtualTextError = { italic = true },
		DiagnosticVirtualTextWarn = { italic = true },
		DiagnosticVirtualTextInfo = { italic = true },
		DiagnosticVirtualTextHint = { italic = true },
	},
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  statusline = {
    enabled = false
  }
}

return M
