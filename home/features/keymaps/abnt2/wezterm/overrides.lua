---@diagnostic disable: undefined-field

local wezterm, module = require "wezterm", {}
local act = wezterm.action

function module.apply_to_config(config)
  -- Set leader key
  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

  if wezterm.gui then
    local copy_mode = wezterm.gui.default_key_tables().copy_mode
    local overrides = {

      -- Movement
      {
        key = "j",
        mods = "NONE",
        action = act.CopyMode "MoveLeft",
      },
      {
        key = "k",
        mods = "NONE",
        action = act.CopyMode "MoveDown",
      },
      {
        key = "l",
        mods = "NONE",
        action = act.CopyMode "MoveUp",
      },
      {
        key = "ç",
        mods = "NONE",
        action = act.CopyMode "MoveRight",
      },
      {
        key = ".",
        mods = "NONE",
        action = act.CopyMode "JumpAgain",
      },
      {
        key = "n",
        mods = "SHIFT",
        action = act.CopyMode "PriorMatch",
      },

      {
        key = "c",
        mods = "NONE",
        action = act.CopyMode "ClearSelectionMode",
      },
      -- Exit Copy mode
      {
        key = "i",
        mods = "NONE",
        action = act.Multiple { "ScrollToBottom", { CopyMode = "Close" } },
      },
    }

    for _, override in ipairs(overrides) do
      table.insert(copy_mode, override)
    end

    overrides = {
      {
        key = "r",
        mods = "CTRL|SHIFT",
        action = act.DisableDefaultAssignment,
      },
      {
        key = "Escape",
        mods = "CTRL",
        action = act.ActivateCopyMode,
      },
      {
        key = "q",
        mods = "CTRL",
        action = act.CloseCurrentPane { confirm = false },
      },
    }

    if not config.keys then
      config.keys = {}
    end
    for _, override in ipairs(overrides) do
      table.insert(config.keys, override)
    end

    config.key_tables = {
      copy_mode = copy_mode,
    }
  end
end

return module
