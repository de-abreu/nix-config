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

  # INFO: Using flake input for opencode-nvim because the
  # nixpkgs version (2025-11-20) is outdated and lacks the `snacks_picker_send`
  # function which was added in Feb 2026 (PR #152).
  # TODO: Remove this overlay once nixpkgs includes opencode.nvim >= v0.6.0.
  opencode-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "opencode.nvim";
    version = "2026-03-29";
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
