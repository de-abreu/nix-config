{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.grug-far;
  prefix = "<leader>ss";
in {
  programs.nixvim = {
    plugins.which-key.settings.spec = lib.optional cfg.enable [
      {
        __unkeyed-1 = prefix;
        group = "Search/Replace";
      }
    ];

    # The Grug-far lazy load triggers, cleanly defined without the mkIf wrapper
    plugins.grug-far.lazyLoad.settings.keys = [
      {
        __unkeyed-1 = prefix + "<CR>";
        __unkeyed-2.__raw = "function() _G.grug_far_open() end";
        mode = "n";
        desc = "Search/Replace workspace";
      }
      {
        __unkeyed-1 = prefix + "e";
        __unkeyed-2.__raw =
          # lua
          ''
            function()
              local ext = vim.fn.expand('%:e')
              _G.grug_far_open({ prefills = { filesFilter = ext ~= "" and "*." .. ext or nil } })
            end
          '';
        mode = "n";
        desc = "Search/Replace filetype";
      }
      {
        __unkeyed-1 = prefix + "f";
        __unkeyed-2.__raw =
          # lua
          ''
            function()
              _G.grug_far_open({ prefills = { paths = vim.fn.fnameescape(vim.fn.expand('%')) } })
            end
          '';
        mode = "n";
        desc = "Search/Replace file";
      }
      {
        __unkeyed-1 = prefix + "w";
        __unkeyed-2.__raw =
          # lua
          ''
            function()
              local cw = vim.fn.expand("<cword>")
              if cw ~= "" then
                _G.grug_far_open({ startCursorRow = 4, prefills = { search = cw } })
              else
                vim.notify("No word under cursor", vim.log.levels.WARN, { title = "Grug-far" })
              end
            end
          '';
        mode = "n";
        desc = "Replace current word";
      }
      {
        __unkeyed-1 = prefix + "s";
        __unkeyed-2.__raw = "function() _G.grug_far_open(nil, true) end";
        mode = "x";
        desc = "Replace selection";
      }
    ];
  };
}
