-- ~/.config/yazi/init.lua
-- User plugin setup for Yazi

-- smart-enter: no config needed by default; see README for options
-- require("smart-enter"):setup {
--   open_multi = true, -- let <l> open multiple selected files
-- }

-- git.yazi: show Git status as linemode in the file list
require("git"):setup {
  -- Order of status signs in the linemode (larger = further right)
  order = 1500,
}

