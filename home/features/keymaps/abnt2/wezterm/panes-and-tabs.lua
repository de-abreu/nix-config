---@diagnostic disable: undefined-field

local wezterm, module = require "wezterm", {}
local act = wezterm.action

function module.apply_to_config(config)
  local mappings = {

    -- Tabs
    {
      key = "m",
      action = wezterm.action_callback(function(_, pane)
        pane:move_to_new_tab()
      end),
    },
    { key = "n", action = act.SpawnTab "CurrentPaneDomain" },
    { key = "j", action = act.ActivateTabRelative(-1) },
    { key = "ç", action = act.ActivateTabRelative(1) },

    -- Split panes
    { key = "-", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "\\", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },

    -- Close or maximize panes
    { key = "q", action = act.CloseCurrentPane { confirm = false } },
    { key = "z", action = act.TogglePaneZoomState },

    -- Swap panes
    { key = "]", action = act.RotatePanes "Clockwise" },
    { key = "[", action = act.RotatePanes "CounterClockwise" },
  }

  if not config.keys then
    config.keys = {}
  end
  for _, m in ipairs(mappings) do
    m.mods = "LEADER"
    table.insert(config.keys, m)
  end

  -- Switch active tab by its index
  local function activate_tab(index)
    return wezterm.action_callback(function(window, pane)
      local tabs = window:mux_window():tabs()
      -- If tab of given index does not yet exist, create it.
      if not tabs[index + 1] then
        window:perform_action(act.SpawnTab "DefaultDomain", pane)
      end
      window:perform_action(act.ActivateTab(index), pane)
    end)
  end

  for i = 0, 9 do
    table.insert(config.keys, {
      mods = "CTRL",
      key = tostring(i),
      action = activate_tab((i - 1) % 10),
    })
  end

  local move_tabs = {
    { mods = "SHIFT | CTRL", key = "j", action = act.MoveTabRelative(-1) },
    { mods = "SHIFT | CTRL", key = ":", action = act.MoveTabRelative(1) },
  }
  for _, m in ipairs(move_tabs) do
    table.insert(config.keys, m)
  end
end

return module
