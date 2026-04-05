let
  mkAction = func: {__raw = "function() require('fastaction').${func}() end";};
in {
  programs.nixvim.plugins.fastaction.lazyLoad.settings.keys = [
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
}
