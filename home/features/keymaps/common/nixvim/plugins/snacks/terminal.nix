{
  config,
  lib,
  options,
  ...
}:
{
  config = lib.mkIf (options ? programs.nixvim) {
    programs.nixvim =
      let
        cfg = config.programs.nixvim.plugins.snacks;
        enable = cfg.enable && ((cfg.settings.terminal.enabled or false) == true) |> lib.mkIf;
        prefix = "<leader>t";

        toggle = {
          key = "<C-t>";

          # Helper to open a specific terminal and remember its position
          function = position: count: {
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
        };
      in
      {
        plugins = {
          which-key.settings.spec = enable [
            {
              __unkeyed-1 = prefix;
              group = "Terminal";
              icon = " ";
            }
          ];

          # Remove overrides from the pickers interfaces
          snacks.settings.picker = {
            win = enable {
              input.keys.${toggle.key} = false;
              list.keys.${toggle.key} = false;
            };
            sources.explorer.win = enable {
              input.keys.${toggle.key} = false;
              list.keys.${toggle.key} = false;
            };
          };
        };

        keymaps = enable (
          map (m: m // { mode = m.mode or "n"; }) [
            {
              key = prefix + "f";
              action = toggle.function "float" 1;
              options = {
                desc = "Floating Terminal";
                silent = true;
              };
            }
            {
              key = prefix + "v";
              action = toggle.function "right" 2;
              options = {
                desc = "Vertical Split Terminal";
                silent = true;
              };
            }
            {
              key = prefix + "h";
              action = toggle.function "bottom" 3;
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
              key = toggle.key;
              action = toggle.function "float" 1;
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
  };
}
