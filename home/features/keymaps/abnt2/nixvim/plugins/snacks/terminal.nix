{
  config,
  lib,
  ...
}: let
  cfg = config.programns.nixvim.plugins.snacks;
  enable = cfg.enable && (cfg.settings.terminal.enabled or false);
  prefix = "<leader>t";
  toggleTerminal = position: {
    __raw =
      # lua
      ''
        function()
          Snacks.terminal.toggle(nil, { win = { position = '${position}' } })
        end
      '';
  };
in {
  programs.nixvim = {
    plugins.which-key.settings.spec = lib.optional enable [
      {
        __unkeyed-1 = prefix;
        group = "Terminal";
        icon = " ";
      }
    ];

    keymaps = lib.mkIf enable (map (m: m // {mode = "n";}) [
      {
        key = prefix + "f";
        action = toggleTerminal "float";
        options = {
          desc = "Floating Terminal";
          silent = true;
        };
      }

      # Vertical Split Terminal (opens on the right)
      {
        key = prefix + "v";
        action = toggleTerminal "right";
        options = {
          desc = "Vertical Split Terminal";
          silent = true;
        };
      }

      # Horizontal Split Terminal (opens at the bottom)
      {
        key = prefix + "h";
        action = toggleTerminal "bottom";
        options = {
          desc = "Horizontal Split Terminal";
          silent = true;
        };
      }
      {
        key = prefix + "l";
        action.__raw = "function() Snacks.lazygit() end";
        options.desc = "Open lazygit";
      }
    ]);
  };
}
