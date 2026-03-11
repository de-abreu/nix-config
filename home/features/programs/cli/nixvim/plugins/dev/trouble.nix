{
  programs.nixvim.plugins.trouble = {
    enable = true;
    lazyLoad.settings.cmd = ["Trouble"];

    settings = {
      auto_close = true;
      modes.diagnostics.filter.__raw =
        # lua
        ''
          function(items)
            return vim.tbl_filter(function(item)
              return not string.match(item.basename, [[%__virtual.cs$]])
            end, items)
          end
        '';

      preview_split = {
        auto_open = true;
        mode = "diagnostics";
        preview = {
          type = "split";
          relative = "win";
          position = "right";
          size = 0.5;
        };
      };

      preview_float = {
        mode = "diagnostics";
        preview = {
          type = "float";
          relative = "editor";
          border = "rounded";
          title = "Preview";
          title_pos = "center";
          position = [0 (-2)];
          size = {
            width = 0.3;
            height = 0.3;
          };
          zindex = 200;
        };
      };
    };
  };
}
