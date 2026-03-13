{
  programs.nixvim.plugins.snacks.settings.picker =
    let
      truncate =
        # lua
        ''
          function(self)
            self:execute 'calculate_file_truncate_width'
          end
        '';
    in
    {
      enable = true;
      win = {
        list.on_buf.__raw = truncate;
        preview = {
          on_buf.__raw = truncate;
          on_close.__raw = truncate;
        };
      };

      layouts.select.layout = {
        relative = "cursor";
        width = 70;
        min_width = 0;
        row = 1;
      };
    };
}
