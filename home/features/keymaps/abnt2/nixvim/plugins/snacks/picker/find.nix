{
  config,
  flakePath,
  lib,
  ...
}: let
  cfg = config.programns.nixvim.plugins.snacks;
  enable = cfg.enable && (cfg.settings.picker.enabled or false);
  mkAction = func: {__raw = "function() Snacks.picker.${func}() end";};
  prefix = "<leader>f";
in {
  programs.nixvim = {
    plugins.which-key.settings.spec = lib.mkIf enable [
      {
        __unkeyed-1 = prefix;
        mode = "n";
        group = "Find";
      }
    ];

    keymaps = lib.mkIf enable (map (el: el // {mode = "n";}) [
      {
        action = mkAction "buffers";
        key = prefix + "b";
        options.desc = "Buffers";
      }

      {
        action.__raw =
          # lua
          ''
            function()
              local config_path = vim.fn.expand("${flakePath}")
              local current_cwd = vim.fn.getcwd()

              -- Count "real" buffers (ignore empty/unnamed ones)
              local real_buffer_count = 0
              local bufs = vim.fn.getbufinfo({buflisted = 1})
              for _, buf in ipairs(bufs) do
                if buf.name ~= "" or buf.changed == 1 then
                  real_buffer_count = real_buffer_count + 1
                end
              end

              -- 1. Create a new tab IF we are not in the config dir AND there ARE active buffers
              if current_cwd ~= config_path and real_buffer_count > 0 then
                vim.cmd("tabnew")
              end

              -- 2. Set the cwd to the nix configuration folder
              vim.api.nvim_set_current_dir(config_path)

              -- 3. Open the snacks picker in this directory
              Snacks.picker.smart({ cwd = config_path })
            end
          '';
        key = prefix + "c";
        options = {
          desc = "Find Config File";
          silent = true;
        };
      }

      {
        action = mkAction "files";
        key = prefix + "f";
        options.desc = "Find Files";
      }

      {
        action = mkAction "grep";
        key = prefix + "g";
        options.desc = "Grep files";
      }

      {
        action = mkAction "git_files";
        key = prefix + "g";
        options.desc = "Find Git Files";
      }

      {
        action = mkAction "projects";
        key = prefix + "p";
        options.desc = "Find Projects";
      }

      {
        action = mkAction "recent";
        key = prefix + "r";
        options.desc = "Recent";
      }
    ]);
  };
}
