{
  pkgs,
  lib,
  ...
}: {
  imports = [./integrations];

  programs.nixvim = {
    plugins.grug-far = {
      enable = true;
      settings = {
        transient = true;
        engines = {
          ripgrep.path = lib.getExe pkgs.ripgrep;
          astgrep.path = lib.getExe pkgs.ast-grep;
        };
      };
    };

    extraConfigLuaPre =
      # lua
      ''
        local default_opts = { instanceName = "main" }

        function _G.grug_far_open(opts, with_visual)
          local grug_far = require("grug-far")
          opts = vim.tbl_deep_extend("force", default_opts, opts or {})

          if not grug_far.has_instance(opts.instanceName) then
            grug_far.open(opts)
          else
            if with_visual then
              if not opts.prefills then opts.prefills = {} end
              opts.prefills.search = grug_far.get_current_visual_selection()
            end
            grug_far.open_instance(opts.instanceName)
            if opts.prefills then
              grug_far.update_instance_prefills(opts.instanceName, opts.prefills, false)
            end
          end
        end
      '';
  };
}
