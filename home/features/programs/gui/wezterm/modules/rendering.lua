local module = {}

function module.apply_to_config(config)
	config.front_end = "WebGpu" -- INFO: Fixes font rendering issues, see https://github.com/NixOS/nixpkgs/issues/334650
	config.enable_kitty_graphics = true -- Set the kitty image protocol to render images
	config.max_fps = 120
end

return module
