{
  lib,
  pluginCfg,
  ...
}: let
  prefix = "<leader>d";
in {
  programs.nixvim.keymaps = lib.optionals pluginCfg.dap-ui.enable [
    {
      mode = "n";
      key = prefix + "E";
      action.__raw =
        # lua
        ''
          function()
            vim.ui.input({ prompt = "Expression: " }, function(expr)
              if expr then require("dapui").eval(expr, { enter = true }) end
            end)
          end
        '';
      options.desc = "Evaluate Input";
    }

    {
      mode = "v";
      key = prefix + "E";
      action.__raw = "function() require('dapui').eval() end";
      options.desc = "Evaluate Input";
    }

    {
      mode = "n";
      key = prefix + "u";
      action.__raw = "function() require('dapui').toggle() end";
      options.desc = "Toggle Debugger UI";
    }

    {
      mode = "n";
      key = prefix + "h";
      action.__raw = "function() require('dap.ui.widgets').hover() end";
      options.desc = "Debugger Hover";
    }
  ];
}
