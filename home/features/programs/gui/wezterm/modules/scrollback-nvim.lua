---@diagnostic disable: undefined-field

local wezterm, io, os = require "wezterm", require "io", require "os"
local act, module = wezterm.action, {}

wezterm.on("scrollback-nvim", function(window, pane)
  -- Retrieve the text from the pane
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

  -- Create a temporary file to pass to nvim
  local name = os.tmpname()
  local f = io.open(name, "w+")

  -- local escape_sequence = "\r\27[K"
  f:write(text)
  f:flush()
  f:close()

  -- act.SendString(escape_sequence .. string.format("nvim %s \n", name))
  -- Open a new window running nvim and tell it to open the file
  window:perform_action(
    act.SpawnCommandInNewTab {
      args = { "nvim", name },
    },
    pane
  )

  -- Wait "enough" time for vim to read the file before we remove it.
  -- The window creation and process spawn are asynchronous wrt. Running
  -- this script and are not available, so we just pick a number.
  --
  -- Note: We don't strictly need to remove this file, but it is nice
  -- to avoid cluttering up the temporary directory.
  wezterm.sleep_ms(1000)
  os.remove(name)
end)

function module.apply_to_config(config)
  table.insert(config.keys, {
    key = "s",
    mods = "LEADER",
    action = act.EmitEvent "scrollback-nvim",
  })
end

return module
