{
  programs.nixvim.plugins.snacks.settings.picker =
    let
      bindings = {
        input.keys = {
          "<M-a>" = {
            __unkeyed-1 = "opencode_send";
            mode = "i";
          };
          "." = "opencode_send";
        };
        list.keys."." = "opencode_send";
      };
    in
    {
      actions.opencode_send.__raw = "function(...) return require('opencode').snacks_picker_send(...) end";
      win = bindings;
      sources.explorer.win = bindings;
    };
}
