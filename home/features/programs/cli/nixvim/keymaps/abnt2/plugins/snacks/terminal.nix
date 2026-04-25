{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.snacks;
  enable = cfg.enable && ((cfg.settings.terminal.enabled or false) == true);
  prefix = "<leader>t";

  # Helper to open a specific terminal and remember its position
  toggleTerminal = position: count: {
    __raw =
      # lua
      ''
        function()
          Snacks.terminal.toggle(nil, {
            count = ${toString count},
            win = { position = '${position}' }
          })
        end
      '';
  };

in
{
  programs.nixvim = {
    plugins.which-key.settings.spec = lib.optional enable [
      {
        __unkeyed-1 = prefix;
        group = "Terminal";
        icon = " ";
      }
    ];

    keymaps = lib.mkIf enable (
      map (m: m // { mode = m.mode or "n"; }) [
        {
          key = prefix + "f";
          action = toggleTerminal "float" 1;
          options = {
            desc = "Floating Terminal";
            silent = true;
          };
        }
        {
          key = prefix + "v";
          action = toggleTerminal "right" 2;
          options = {
            desc = "Vertical Split Terminal";
            silent = true;
          };
        }
        {
          key = prefix + "h";
          action = toggleTerminal "bottom" 3;
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

        # TODO: Solve ambiguity with the <c-t> keybinding used in the terminal interface.
        {
          key = "<c-t>";
          action = toggleTerminal "float" 1;
          options = {
            desc = "Toggle Floating Terminal";
            silent = true;
          };
          mode = [
            "n"
            "i"
            "t"
          ];
        }
      ]
    );
  };
}
