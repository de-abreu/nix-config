{ lib, options, ... }:
{
  config = lib.mkIf (options ? programs.nixvim) {
    programs.nixvim.plugins.fastaction.lazyLoad.settings.keys =
      let
        mkAction = func: { __raw = "function() require('fastaction').${func}() end"; };
      in
      [
        {
          __unkeyed-1 = "<leader>lc";
          __unkeyed-2 = mkAction "code_action";
          mode = "n";
          desc = "Code action";
        }
        {
          __unkeyed-1 = "<leader>lc";
          __unkeyed-2 = mkAction "range_code_action";
          mode = "v";
          desc = "Code action";
        }
      ];
  };
}
