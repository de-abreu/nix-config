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
  toggleTerminal = position: {
    __raw =
      # lua
      ''
        function()
          _G.snacks_last_term_pos = '${position}'
          Snacks.terminal.toggle(nil, {
            id = "term_${position}", -- Assign a unique ID per orientation
            win = { position = '${position}' }
          })
        end
      '';
  };

  # Helper to toggle the last used terminal (defaults to float)
  toggleLastTerminal = {
    __raw =
      # lua
      ''
        function()
          local pos = _G.snacks_last_term_pos or "float"
          Snacks.terminal.toggle(nil, {
            id = "term_" .. pos, -- Target the specific ID for that orientation
            win = { position = pos }
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
          action = toggleTerminal "float";
          options = {
            desc = "Floating Terminal";
            silent = true;
          };
        }
        {
          key = prefix + "v";
          action = toggleTerminal "right";
          options = {
            desc = "Vertical Split Terminal";
            silent = true;
          };
        }
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

        # TODO: Solve ambiguity with the <c-t> keybinding used in the terminal interface.
        {
          key = "<c-t>";
          action = toggleLastTerminal;
          options = {
            desc = "Toggle Terminal (Last/Float)";
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
