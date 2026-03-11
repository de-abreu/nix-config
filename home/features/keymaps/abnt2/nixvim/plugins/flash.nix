{mkAction, ...}: let
  action = func: mkAction "flash" func {};
in {
  programs.nixvim.plugins.flash.lazyLoad.settings.keys = [
    {
      __unkeyed-1 = "s";
      __unkeyed-2 = action "jump";
      mode = ["n" "x" "o"];
      desc = "Flash";
    }

    {
      __unkeyed-1 = "S";
      __unkeyed-2 = action "treesitter";
      mode = ["n" "x" "o"];
      desc = "Flash Treesitter";
    }

    {
      __unkeyed-1 = "r";
      __unkeyed-2 = action "remote";
      mode = "o";
      desc = "Remote Flash";
    }

    {
      __unkeyed-1 = "R";
      __unkeyed-2 = action "treesitter_search";
      mode = ["o" "x"];
      desc = "Treesitter Search";
    }

    {
      __unkeyed-1 = "gl";
      __unkeyed-2 = {
        __raw = ''
          function()
            require('flash').jump({
              search = { mode = 'search', max_length = 0 },
              label = { after = { 0, 0 } },
              pattern = '^',
            })
          end
        '';
      };
      mode = ["n" "x" "o"];
      desc = "Flash Line";
    }
  ];
}
