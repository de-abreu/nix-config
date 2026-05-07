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
  port = toString (opencode.settings.server.port or "");
  snacks_terminal_opts = config.lib.nixvim.lua.toLuaObject {
    win = {
      position = "right";
      enter = false;
      on_win.__raw = "function(win) require('opencode.terminal').setup(win.win) end";
    };
  };

  # INFO: Following the latest release.
  opencode-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "opencode.nvim";
    version = "main";
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
          auto_reload = true;
          port = port;
          server =
            let
              opencodeCmd = lib.getExe opencode.package;
            in
            lib.mkIf snacks.enable {
              start.__raw = "function() require('snacks.terminal').open('${opencodeCmd}', ${snacks_terminal_opts}) end";
              stop.__raw = "function() require('snacks.terminal').get('${opencodeCmd}', ${snacks_terminal_opts}):close() end";
              toggle.__raw = "function() require('snacks.terminal').toggle('${opencodeCmd}', ${snacks_terminal_opts}) end";
            };
        };
      };
      lualine.settings.lualine_z.sections.__unkeyed-1.__raw = "require('opencode').statusline";
    };

    globals.opencode_opts.lsp.enabled = true;
  };
}
