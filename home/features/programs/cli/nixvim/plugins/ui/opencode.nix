{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  snacks = config.programs.nixvim.plugins.snacks;
  opencode = config.programs.opencode;
  opencodeCmd = lib.getExe opencode.package;

  # INFO: Following the latest release.
  opencode-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "opencode.nvim";
    version = "2026-06-07";
    src = inputs.opencode-nvim;
  };
in
{
  programs.nixvim = {
    # INFO: lsof is required by opencode.nvim for port discovery when searching
    # for running opencode servers. See lua/opencode/server/process/unix.lua.
    extraPackages = [ pkgs.lsof ];

    plugins = lib.mkIf opencode.enable {
      opencode = {
        package = opencode-nvim;
        enable = true;
        lazyLoad.settings.lazy = true;

        settings = {
          server =
            let
              snacks_terminal_opts = config.lib.nixvim.lua.toLuaObject {
                win = {
                  position = "right";
                  enter = false;
                };
              };
            in
            lib.mkIf snacks.enable {
              start.__raw = "function() require('snacks.terminal').open('${opencodeCmd}', ${snacks_terminal_opts}) end";
            };
        };
      };
      lualine.settings.lualine_z.sections.__unkeyed-1.__raw = "require('opencode').statusline";
    };

    globals.opencode_opts = {
      lsp.enabled = true;
      events.reload = true;
    };

    autoCmd = lib.mkIf snacks.enable [
      {
        event = "User";
        pattern = "OpencodeEvent:tui.command.execute";
        callback.__raw = ''
          function(args)
            local event = args.data.event
            if event.properties.command == 'prompt.submit' then
              local win = require('snacks.terminal').get('${opencodeCmd}', { create = false })
              if win then
                win:show()
              end
            end
          end
        '';
      }
    ];
  };
}
