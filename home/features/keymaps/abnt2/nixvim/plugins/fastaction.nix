{mkAction, ...}: let
  action = func: mkAction "fastaction" func {};
in {
  programs.nixvim.plugins.fastaction.lazyLoad.settings.keys = [
    {
      __unkeyed-1 = "<leader>lc";
      __unkeyed-2 = action "code_action";
      mode = "n";
      desc = "Code action";
    }
    {
      __unkeyed-1 = "<leader>lc";
      __unkeyed-2 = action "range_code_action";
      mode = "v";
      desc = "Code action";
    }
  ];
}
