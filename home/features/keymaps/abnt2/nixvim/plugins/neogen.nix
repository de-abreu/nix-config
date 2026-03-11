{
  lib,
  mkAction,
  pluginCfg,
  ...
}: let
  prefix = "<leader>a";
  action = type: mkAction "neogen" "generate" {opts = "{ type = '${type}' }";};
in {
  programs.nixvim = {
    # --- Which-Key Grouping ---
    plugins.which-key.settings.spec = lib.mkIf pluginCfg.neogen.enable [
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
        __unkeyed-2 = action "any";
        mode = "n";
        desc = "Current";
      }
      {
        __unkeyed-1 = prefix + "c";
        __unkeyed-2 = action "class";
        mode = "n";
        desc = "Class";
      }
      {
        __unkeyed-1 = prefix + "f";
        __unkeyed-2 = action "func";
        mode = "n";
        desc = "Function";
      }
      {
        __unkeyed-1 = prefix + "t";
        __unkeyed-2 = action "type";
        mode = "n";
        desc = "Type";
      }
      {
        __unkeyed-1 = prefix + "F";
        __unkeyed-2 = action "file";
        mode = "n";
        desc = "File";
      }
    ];
  };
}
