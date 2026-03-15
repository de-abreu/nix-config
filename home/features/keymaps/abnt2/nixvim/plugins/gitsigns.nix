{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins;
  enable = cfg.gitsigns.enable && cfg.which-key.enable;
in
{
  programs.nixvim.plugins.gitsigns.settings.on_attach =
    lib.mkIf enable
      # lua
      ''
        function(bufnr)
          local gs = require('gitsigns')
          local wk = require('which-key')
          local prefix = "<leader>gh"

          -- 1. Create the buffer-local Hunk menu
          wk.add({
            { prefix, group = "Hunk Actions", icon = " ", buffer = bufnr },
          })

          -- 2. Helper for buffer-local mappings
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          map('n', ']g', function() gs.nav_hunk('next') end, "Next Git hunk")
          map('n', '[g', function() gs.nav_hunk('prev') end, "Previous Git hunk")
          map('n', ']G', function() gs.nav_hunk('last') end, "Last Git hunk")
          map('n', '[G', function() gs.nav_hunk('first') end, "First Git hunk")

          -- Hunk Actions (The <leader>gh menu)
          map('n', prefix .. "l", gs.blame_line, "View Git blame")
          map('n', prefix .. "L", function() gs.blame_line { full = true } end, "View full Git blame")
          map('n', prefix .. "p", gs.preview_hunk_inline, "Preview Git hunk")
          map('n', prefix .. "r", gs.reset_hunk, "Reset Git hunk")
          map('n', prefix .. "R", gs.reset_buffer, "Reset Git buffer")
          map('n', prefix .. "s", gs.stage_hunk, "Stage/Unstage Git hunk")
          map('n', prefix .. "S", gs.stage_buffer, "Stage Git buffer")
          map('n', prefix .. "d", gs.diffthis, "View Git diff")

          -- Visual Mode Actions (Handling ranges)
          map('v', prefix .. "r", function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Reset Git hunk")
          map('v', prefix .. "s", function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage Git hunk")

          -- Text Objects (inside git hunk)
          map({'o', 'x'}, 'ig', ':<C-U>Gitsigns select_hunk<CR>', "inside Git hunk")
        end
      '';
}
