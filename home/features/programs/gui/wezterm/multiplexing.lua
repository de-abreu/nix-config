---@diagnostic disable: undefined-field
local module = {}

function module.apply_to_config(config)
  -- Attempt to query current workspace
  -- local handle, workspace = io.popen "hyprctl activeworkspace", "unix"
  --
  -- if handle then
  --   local output = handle:read "*l"
  --   workspace = output:match "workspace ID %d+"
  --   handle:close()
  -- end

  -- Create and/or attach to a multiplexer assigned to the current workspace on startup
  config.unix_domains = { { name = "unix" } }
  config.default_gui_startup_args = { "connect", "unix" }
end

return module
