{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.neogen;
  prefix = "<leader>A";
  mkAction = type: {
    __raw = "function() require('neogen').generate({ type = '${type}' }) end";
  };
in
{
  programs.nixvim = {
    # --- Which-Key Grouping ---
    plugins.which-key.settings.spec = lib.optional cfg.enable [
      {
        __unkeyed-1 = prefix;
        mode = "n";
        group = "Annotation";
        icon = "󰷉 ";
      }
    ];

    # --- Lazy Load Triggers ---
    plugins.neogen.lazyLoad.settings.keys = [
      {
        __unkeyed-1 = prefix + "<CR>";
        __unkeyed-2 = mkAction "any";
        mode = "n";
        desc = "Current";
      }
      {
        __unkeyed-1 = prefix + "c";
        __unkeyed-2 = mkAction "class";
        mode = "n";
        desc = "Class";
      }
      {
        __unkeyed-1 = prefix + "f";
        __unkeyed-2 = mkAction "func";
        mode = "n";
        desc = "Function";
      }
      {
        __unkeyed-1 = prefix + "t";
        __unkeyed-2 = mkAction "type";
        mode = "n";
        desc = "Type";
      }
      {
        __unkeyed-1 = prefix + "F";
        __unkeyed-2 = mkAction "file";
        mode = "n";
        desc = "File";
      }
    ];
  };
}
