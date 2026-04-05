{
  config,
  lib,
  pkgs,
  ...
}:
let
  snacks = config.programs.nixvim.plugins.snacks;
  opencode = config.programs.opencode;
  port = toString (opencode.settings.server.port or "");
  opencode_cmd = "opencode --port ${port}";
  snacks_terminal_opts = config.lib.nixvim.lua.toLuaObject {
    win = {
      position = "right";
      enter = false;
      on_win.__raw = "function(win) require('opencode.terminal').setup(win.win) end";
    };
  };

  # INFO: Fetching opencode-nvim from GitHub instead of nixpkgs because the
  # nixpkgs version (2025-11-20) is outdated and lacks the `snacks_picker_send`
  # function which was added in Feb 2026 (PR #152).
  # TODO: Remove this overlay once nixpkgs includes opencode.nvim >= v0.6.0.
  opencode-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "opencode.nvim";
    version = "2026-03-29";
    src = pkgs.fetchFromGitHub {
      owner = "nickjvandyke";
      repo = "opencode.nvim";
      rev = "v0.6.0";
      hash = "sha256-Lm0/59MWndrpU6D4+Gdpgnel7B3Q6jR3z6cgSUF2XuQ=";
    };
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
          server = lib.mkIf snacks.enable {
            start.__raw = "function() require('snacks.terminal').open('${opencode_cmd}', ${snacks_terminal_opts}) end";
            stop.__raw = "function() require('snacks.terminal').get('${opencode_cmd}', ${snacks_terminal_opts}):close() end";
            toggle.__raw = "function() require('snacks.terminal').toggle('${opencode_cmd}', ${snacks_terminal_opts}) end";
          };
        };
      };
      lualine.settings.lualine_z.sections.__unkeyed-1.__raw = "require('opencode').statusline";
    };

    globals.opencode_opts.lsp.enabled = true;
  };
}
