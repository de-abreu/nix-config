let
  mkAction = func: { __raw = "function() require('flash').${func}() end"; };
in
{
  programs.nixvim.plugins = {
    flash.lazyLoad.settings.keys = [
      {
        __unkeyed-1 = "h";
        __unkeyed-2 = mkAction "jump";
        mode = [
          "n"
          "x"
          "o"
        ];
        desc = "Flash";
      }

      {
        __unkeyed-1 = "H";
        __unkeyed-2 = mkAction "treesitter";
        mode = [
          "n"
          "x"
          "o"
        ];
        desc = "Flash Treesitter";
      }

      {
        __unkeyed-1 = "r";
        __unkeyed-2 = mkAction "remote";
        mode = "o";
        desc = "Remote Flash";
      }

      {
        __unkeyed-1 = "R";
        __unkeyed-2 = mkAction "treesitter_search";
        mode = [
          "o"
          "x"
        ];
        desc = "Treesitter Search";
      }

      {
        __unkeyed-1 = "gl";
        __unkeyed-2 = {
          __raw =
            # lua
            ''
              function()
                require('flash').jump({
                  search = { mode = 'search', max_length = 0 },
                  label = { after = { 0, 0 } },
                  pattern = '^',
                })
              end
            '';
        };
        mode = [
          "n"
          "x"
          "o"
        ];
        desc = "Flash Line";
      }
    ];
    hardtime.settings.restricted_keys.h.__raw = "false";
    snacks.settings.picker = {
      input.keys.h = "flash";
      lists.keys.h = "flash";
    };
  };
}
