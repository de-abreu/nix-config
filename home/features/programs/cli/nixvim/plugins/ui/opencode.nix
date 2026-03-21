{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.snacks;
  enable = cfg.enable && ((cfg.settings.terminal.enabled or false) == true);
  port = "8765";
  opencode_cmd = "opencode --port ${port}";
  snacks_terminal_opts = config.lib.nixvim.lua.toLuaObject {
    win = {
      position = "right";
      enter = false;
      on_win.__raw = "function(win) require('opencode.terminal').setup(win.win) end";
    };
  };
in
{
  programs.nixvim = {

    # INFO: Match the version installed in the terminal
    nixpkgs.overlays = [
      (final: prev: {
        opencode = pkgs.unstable.opencode;
      })
    ];

    extraConfigLuaPre =
      let
        inherit (config.sops) secrets;
      in
      # lua
      ''
        -- Helper function to read a secret file and set an environment variable
        local function load_secret(file_path, env_var_name)
          local key_file = io.open(file_path, "r")

          if key_file then
            vim.env[env_var_name] = key_file:read("*a"):gsub("%s+", "")
            key_file:close()
          else
            vim.notify("Sops secret not found: " .. file_path, vim.log.levels.WARN)
          end
        end

        -- Inject the OpenCode API key
        load_secret('${secrets."api-keys/opencode-go".path}', "OPENCODE_API_KEY")

        -- Inject the DeepSeek API key
        load_secret('${secrets."api-keys/deepseek".path}', "DEEPSEEK_API_KEY")
      '';

    extraPackages = [ pkgs.wezterm ];

    plugins = {
      opencode = {
        enable = true;

        settings = {
          auto_reload = true;
          port = port;
          server = lib.mkIf enable {
            # Inject the variables directly into the raw Lua strings
            start.__raw = "function() require('snacks.terminal').open('${opencode_cmd}', ${snacks_terminal_opts}) end";
            stop.__raw = "function() require('snacks.terminal').get('${opencode_cmd}', ${snacks_terminal_opts}):close() end";
            toggle.__raw = "function() require('snacks.terminal').toggle('${opencode_cmd}', ${snacks_terminal_opts}) end";
          };
        };
      };
      lualine.settings.lualine_z.sections.__unkeyed-1.__raw = "require('opencode').statusline";
    };

    # INFO Enable experimental lsp integration
    globals.opencode_opts.lsp.enabled = true;
  };
}
