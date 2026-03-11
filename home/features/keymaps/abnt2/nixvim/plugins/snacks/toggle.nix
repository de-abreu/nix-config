{
  snacksCfg,
  featuresEnabled,
  lib,
  snacksAction,
  ...
}: let
  feat = "toggle";
  prefix = "<leader>u";
  toggle = func: snacksAction "${feat}.${func}" {};
  toggleOpt = name: opt: {
    __raw =
      # lua
      "function() Snacks.toggle.option('${opt}', { name = '${name}' }):toggle() end";
  };
in {
  programs.nixvim.keymaps =
    map (m: m // {mode = "n";})
    (lib.optionals
      (featuresEnabled feat)
      [
        {
          key = prefix + "d";
          action = toggle "diagnostics";
          options.desc = "Toggle Diagnostics";
        }
        {
          key = prefix + "s";
          action = toggleOpt "Spelling" "spell";
          options.desc = "Toggle Spellcheck";
        }
        {
          key = prefix + "w";
          action = toggleOpt "Wrap" "wrap";
          options.desc = "Toggle Word Wrap";
        }
        {
          key = prefix + "l";
          action = toggle "line_number()";
          options.desc = "Toggle Line Numbers";
        }
        {
          key = prefix + "L";
          action = toggleOpt "Relative Number" "relativenumber";
          options.desc = "Toggle Relative Lines";
        }
        {
          key = prefix + "h";
          action = toggle "inlay_hints()";
          options.desc = "Toggle Inlay Hints";
        }
        {
          key = prefix + "i";
          action = toggle "indent()";
          options.desc = "Toggle Indent Guides";
        }
        {
          key = prefix + "t";
          action = toggle "treesitter";
          options.desc = "Toggle Treesitter";
        }
        {
          key = prefix + "w"; # Re-mapping your custom whitespace to W (capital)
          options.desc = "Toggle Whitespace Characters";
          action.__raw =
            # lua
            ''
              function()
                if (not vim.g.whitespace_character_enabled) then
                  vim.opt.listchars = { eol = "¬", tab = ">→", trail = "~", space = "·" }
                  vim.opt.list = true
                else
                  vim.opt.list = false
                end
                vim.g.whitespace_character_enabled = not vim.g.whitespace_character_enabled
                vim.notify("Whitespace visibility: " .. tostring(vim.g.whitespace_character_enabled))
              end
            '';
        }
        {
          action.__raw =
            # lua
            ''
              function()
                local curr_foldcolumn = vim.wo.foldcolumn
                if curr_foldcolumn ~= "0" then vim.g.last_active_foldcolumn = curr_foldcolumn end
                vim.wo.foldcolumn = curr_foldcolumn == "0" and (vim.g.last_active_foldcolumn or "1") or "0"
                vim.notify(string.format("Fold Column %s", tostring(vim.wo.foldcolumn), "info"))
              end
            '';
          key = prefix + "o";
          options.desc = "Toggle Fold Column";
        }
      ]
      ++ lib.optionals (snacksCfg.zen.enabled) [
        {
          key = prefix + "z";
          action = toggle "zen";
          options.desc = "Toggle Zen Mode";
        }
        {
          key = prefix + "m";
          action = toggle "zoom";
          options.desc = "Toggle Maximize (Zoom)";
        }
      ]
      ++ lib.optionals (snacksCfg.dim.enabled) [
        {
          key = prefix + "D";
          action = toggle "dim";
          options.desc = "Toggle Dim Mode";
        }
      ]);
}
