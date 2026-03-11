{
  lib,
  pluginCfg,
  ...
}: let
  prefix = "<leader>x";
in {
  programs.nixvim = {
    plugins.which-key.settings.spec = lib.optional pluginCfg.trouble.enable [
      {
        __unkeyed-1 = prefix;
        mode = "n";
        icon = "";
        group = "Trouble";
      }
    ];

    keymaps = lib.optionals pluginCfg.trouble.enable [
      {
        mode = "n";
        key = prefix + "x";
        action = "<cmd>Trouble preview_split toggle<cr>";
        options.desc = "Diagnostics toggle";
      }
      {
        mode = "n";
        key = prefix + "X";
        action = "<cmd>Trouble preview_split toggle filter.buf=0<cr>";
        options.desc = "Buffer Diagnostics toggle";
      }
      {
        mode = "n";
        key = "<leader>us";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        options.desc = "Symbols toggle";
      }
      {
        mode = "n";
        key = prefix + "l";
        action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
        options.desc = "LSP Definitions / references / ... toggle";
      }
      {
        mode = "n";
        key = prefix + "L";
        action = "<cmd>Trouble loclist toggle<cr>";
        options.desc = "Location List toggle";
      }
      {
        mode = "n";
        key = prefix + "Q";
        action = "<cmd>Trouble qflist toggle<cr>";
        options.desc = "Quickfix List toggle";
      }
    ];
  };
}
