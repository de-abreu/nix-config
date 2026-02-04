-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

return {
  "AstroNvim/astrocore",
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        mouse = "", -- Disable the mouse
        clipboard = "unnamedplus", -- Enable clipboard access

        -- Localization and spell check options
        spell = true, -- sets vim.opt.spell
        spelllang = { "en_us", "pt_br" },
        -- rtp:append("~/.config/nvim/")

        -- Softwrap options
        wrap = true, -- Enable line wrapping
        linebreak = true, -- Break lines at "breakat" characters, thus not splitting words
        breakindent = true, -- Preserve indentation when breaking lines
        whichwrap = "b,s,h,l", -- Set keys which can make the cursor wrap lines

        -- Set tab length
        shiftwidth = 0, -- Set to zero to return the same value as tabstop
        tabstop = 2,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    mappings = (function()
      local no_operation = {
        ["<Down>"] = "<nop>",
        ["<End>"] = "<nop>",
        ["<PageDown>"] = "<nop>",
        ["<PageUp>"] = "<nop>",
        ["<Up>"] = "<nop>",
      }

      local keep_selection = {
        [">"] = { ">gv", desc = "Indent selection" },
        ["<"] = { "<gv", desc = "Dedent selection" },
      }

      return {
        i = no_operation,
        n = no_operation,
        o = no_operation,
        v = require("astrocore").extend_tbl(no_operation, keep_selection),
      }
    end)(),
  },
}
