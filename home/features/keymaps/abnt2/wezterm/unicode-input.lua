local wezterm = require "wezterm"
local unicode_input = wezterm.plugin.require "https://github.com/de-abreu/wezterm-unicode-input"
local module = {}

function module.apply_to_config(config)
  if not config.keys then
    config.keys = {}
  end

  table.insert(config.keys, {
    key = "/",
    mods = "CTRL",
    action = wezterm.action.CharSelect,
  })

  unicode_input.apply_to_config(config, {
    sequences = {
      ["103"] = "ă",
      ["102"] = "Ă",
      ["e2"] = "â",
      ["c2"] = "Â",
      ["ea"] = "ê",
      ["ca"] = "Ê",
      ["ee"] = "î",
      ["ce"] = "Î",
      ["f4"] = "ô",
      ["d4"] = "Ô",
      ["fb"] = "û",
      ["db"] = "Û",
      ["219"] = "ș",
      ["218"] = "Ș",
      ["21b"] = "ț",
      ["21a"] = "Ț",
    },
  })
end

return module
