{ config, ... }:
let
  icons = import ../_icons.nix;
in
{
  programs.nixvim = {
    autoCmd = [
      {
        event = [
          "RecordingEnter"
          "RecordingLeave"
        ];
        callback.__raw = ''
          function()
            require('lualine').refresh()
          end
        '';
      }
    ];

    plugins.lualine = {
      settings.sections.lualine_c = [
        {
          __unkeyed-1 = "%=";
          separator = {
            left = "";
            right = "";
          };
        }

        {
          __unkeyed-1.__raw = ''
            function()
              local reg = vim.fn.reg_recording()
              if reg == "" then return "" end
              return "${icons.macroRecording} Recording @" .. reg
            end
          '';

          # Setting a distinctive color to catch the user's eye
          color = {
            fg =
              if config ? stylix && config.stylix.enable then
                config.lib.stylix.colors.withHashtag.base09
              else
                "#ff9e64";
            gui = "bold";
          };
        }
      ];
    };
  };
}
