{
  programs.nixvim.plugins.snacks.settings.picker =
    let
      bindings = {
        input.keys = {
          "<c-g>" = {
            __unkeyed-1 = "grug_far_replace";
            mode = "i";
          };
          s = "grug_far_replace";
        };
        list.keys.s = "grug_far_replace";
      };

    in
    {
      actions.grug_far_replace.__raw =
        # lua
        ''
          function(picker, item)
            if not item then return end

            -- Determine the path from the picker item
            local path = item.file or item.dir or item.text
            if not path then return end

            -- If it's a file, get its parent directory. If it's already a dir, keep it.
            local dir = vim.fn.isdirectory(path) == 1 and path or vim.fn.fnamemodify(path, ":h")

            -- Close snacks.picker
            picker:close()

            -- Trigger our global grug-far function with the directory prefilled
            _G.grug_far_open({ prefills = { paths = dir } })
          end
        '';

      win = bindings;
      sources.explorer.win = bindings;
    };
}
