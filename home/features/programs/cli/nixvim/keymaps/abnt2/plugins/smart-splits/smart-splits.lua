---@diagnostic disable: undefined-field
-- INFO: Allow the cursor to navigate between Neovim windows and Wezterm panes

local wezterm, module = require "wezterm", {}
local smart_splits = wezterm.plugin.require "https://github.com/mrjones2014/smart-splits.nvim"

function module.apply_to_config(config)
  -- INFO: Set directional keys in consonance with Nvim
  smart_splits.apply_to_config(config, {
    -- directional keys to use in order of: left, down, up, right
    -- NOTE: When combined with modifier keys, "ç" is read as ";"
    direction_keys = { "j", "k", "l", ";" },
    modifiers = {
      move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+j to move left
      resize = "META", -- modifier to use for pane resize, e.g. META+j to resize to the left
    },
    -- log level to use: info, warn, error
    log_level = "info",
  })
end

return module
