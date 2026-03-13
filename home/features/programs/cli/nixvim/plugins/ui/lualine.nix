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
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
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
              return "  Recording @" .. reg
            end
          '';
          # Optional: Give it a distinct color so it catches your eye
          color = {
            fg = "#ff9e64";
            gui = "bold";
          };
        }
      ];
    };
  };
}
