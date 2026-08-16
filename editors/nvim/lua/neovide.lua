-- Neovide-only (https://neovide.dev/configuration.html)

local font_configured = false
local zoom_configured = false

local function is_neovide()
  return vim.g.neovide ~= nil and vim.g.neovide ~= false and vim.g.neovide ~= 0
end

local function setup_font()
  if not is_neovide() or font_configured then
    return
  end
  font_configured = true

  -- ┌─ scale_factor ──────────────────────────────────────────────────────────┐
  -- │ Scales the entire UI (font + everything). Float value.                 │
  -- │ 1.0 = default, 0.8 = smaller, 1.2 = larger                            │
  -- │ Use Ctrl +/- keymaps below to change at runtime                        │
  -- └────────────────────────────────────────────────────────────────────────┘
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor or 1.0

  -- ┌─ linespace ────────────────────────────────────────────────────────────┐
  -- │ Adds/removes pixels between lines.                                    │
  -- │ OPTIONS: 0 (default), 1/2/3 (taller), -1/-2/-3 (tighter, may clip)   │
  -- └────────────────────────────────────────────────────────────────────────┘
  vim.o.linespace = 0

  -- Fira Code has no italic variant; strip synthetic italics so Neovide matches the TUI.
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      local hls = vim.api.nvim_get_hl(0, {})
      for name, hl in pairs(hls) do
        if hl.italic then
          hl.italic = false
          vim.api.nvim_set_hl(0, name, hl)
        end
      end
    end,
  })
  local hls = vim.api.nvim_get_hl(0, {})
  for name, hl in pairs(hls) do
    if hl.italic then
      hl.italic = false
      vim.api.nvim_set_hl(0, name, hl)
    end
  end
end

local function setup_appearance()
  if not is_neovide() then
    return
  end

  -- vim.g.neovide_cursor_animation_length = 0.13
  -- vim.g.neovide_cursor_short_animation_length = 0.035
  -- vim.g.neovide_scroll_animation_length = 0.26
  -- vim.g.neovide_scroll_animation_far_lines = 1

  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_short_animation_length = 0.035
  vim.g.neovide_scroll_animation_length = 0.26
  vim.g.neovide_scroll_animation_far_lines = 1
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_floating_blur_amount_x = 0.0
  vim.g.neovide_floating_blur_amount_y = 0.0
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_floating_corner_radius = 0.0
  vim.g.neovide_window_blurred = false
  vim.g.neovide_progress_bar_enabled = false
end

local ZOOM_MODES = { "n", "i", "v", "x", "t", "c" }
local ZOOM_STEP = 1.05
local ZOOM_MIN = 0.5
local ZOOM_MAX = 3.0

local function change_scale_factor(delta)
  local cur = tonumber(vim.g.neovide_scale_factor) or 1.0
  vim.g.neovide_scale_factor = math.max(ZOOM_MIN, math.min(ZOOM_MAX, cur * delta))
end

local function setup_zoom_keymaps()
  if not is_neovide() or zoom_configured then
    return
  end
  zoom_configured = true

  local function map_zoom(lhs, delta, desc)
    vim.keymap.set(ZOOM_MODES, lhs, function()
      change_scale_factor(delta)
    end, { silent = true, desc = desc })
  end

  map_zoom("<C-=>", ZOOM_STEP, "Neovide: zoom in")
  map_zoom("<C-+>", ZOOM_STEP, "Neovide: zoom in")
  map_zoom("<C-S-=>", ZOOM_STEP, "Neovide: zoom in")
  map_zoom("<C-->", 1 / ZOOM_STEP, "Neovide: zoom out")
  map_zoom("<C-_>", 1 / ZOOM_STEP, "Neovide: zoom out")

  vim.keymap.set(ZOOM_MODES, "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { silent = true, desc = "Neovide: reset zoom" })
end

local function setup_clipboard()
  if not is_neovide() then
    return
  end

  local function paste_clipboard()
    vim.api.nvim_paste(vim.fn.getreg "+", true, -1)
  end
  vim.keymap.set({ "n", "x" }, "<C-S-v>", paste_clipboard, { desc = "Paste from clipboard" })
  vim.keymap.set("i", "<C-S-v>", paste_clipboard, { desc = "Paste from clipboard" })
  vim.keymap.set("c", "<C-S-v>", "<C-R>+", { desc = "Paste in command line" })
  vim.keymap.set("t", "<C-S-v>", paste_clipboard, { desc = "Paste in terminal" })
end

local function setup()
  setup_appearance()
  setup_font()
  setup_zoom_keymaps()
  setup_clipboard()
end

setup()
vim.api.nvim_create_autocmd("VimEnter", { once = true, callback = setup })
vim.schedule(setup)
