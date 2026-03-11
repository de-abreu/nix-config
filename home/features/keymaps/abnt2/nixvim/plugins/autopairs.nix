{
  programs.nixvim = {
    plugins.nvim-autopairs = {
      settings.fastWrap = {
        map = "<M-e>";
        keys = "qwertyuiopzxcvbnmasdfghjkl";
      };
      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<Leader>ua";
          __unkeyed-2.__raw =
            # lua
            ''
              function()
                local ap = require "nvim-autopairs"
                if ap.state.disabled then
                  ap.enable()
                  print("Autopairs Enabled")
                else
                  ap.disable()
                  print("Autopairs Disabled")
                end
              end
            '';
          mode = "n";
          desc = "Toggle autopairs";
        }
      ];
    };
  };
}
