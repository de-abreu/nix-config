---@diagnostic disable: undefined-field
---@diagnostic disable: undefined-global

local wezterm, module = require("wezterm"), {}
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local function leader(window)
	return window:leader_is_active() and string.format(" %s  ", wezterm.nerdfonts.md_trello) or " "
end

function module.apply_to_config(config)
	tabline.setup({
		options = {
			theme = config.color_scheme,
			section_separators = "",
			component_separators = {
				left = wezterm.nerdfonts.ple_backslash_separator,
				right = wezterm.nerdfonts.ple_forwardslash_separator,
			},
			tab_separators = {
				left = "",
				right = " ",
			},
		},
		sections = {
			tabline_a = { leader },
			tabline_x = { "" },
			tabline_y = { "" },
		},
	})
end

return module
