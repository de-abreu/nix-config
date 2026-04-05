{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.snacks;
  enable = cfg.enable && ((cfg.settings.picker.enabled or false) == true);
  prefix = "<leader>s";
  mkAction = func: { __raw = "function() Snacks.picker.${func}() end"; };
in
{
  programs.nixvim = {
    plugins.which-key.settings.spec = lib.mkIf enable [
      {
        __unkeyed-1 = prefix;
        mode = "n";
        group = "Search";
      }
    ];

    keymaps = lib.mkIf enable (
      map (m: m // { mode = m.mode or "n"; }) [
        {
          action = mkAction "resume";
          key = prefix + "<space>";
          options.desc = "Resume";
        }
        {
          action = mkAction "search_history";
          key = prefix + "/";
          options.desc = "Search History";
        }
        {
          action = mkAction "autocmds";
          key = prefix + "a";
          options.desc = "Autocmds";
        }
        {
          action = mkAction "lines";
          key = prefix + "b";
          options.desc = "Buffer lines";
        }
        {
          action = mkAction "grep_buffers";
          key = prefix + "B";
          options.desc = "Grep open buffers";
        }
        {
          action = mkAction "grep_word";
          key = prefix + "w";
          options.desc = "Visual selection or word";
          mode = [
            "n"
            "x"
          ];
        }
        {
          action = mkAction "command_history";
          key = prefix + "c";
          options.desc = "Command History";
        }
        {
          action = mkAction "commands";
          key = prefix + "C";
          options.desc = "Commands";
        }
        {
          action = mkAction "diagnostics";
          key = prefix + "D";
          options.desc = "Diagnostics";
        }
        {
          action = mkAction "diagnostics_buffer";
          key = prefix + "d";
          options.desc = "Buffer Diagnostics";
        }
        {
          action = mkAction "help";
          key = prefix + "h";
          options.desc = "Help Pages";
        }
        {
          action = mkAction "highlights";
          key = prefix + "H";
          options.desc = "Highlights";
        }
        {
          action = mkAction "icons";
          key = prefix + "i";
          options.desc = "Icons";
        }
        {
          action = mkAction "jumps";
          key = prefix + "j";
          options.desc = "Jumps";
        }
        {
          action = mkAction "keymaps";
          key = prefix + "k";
          options.desc = "Keymaps";
        }
        {
          action = mkAction "loclist";
          key = prefix + "l";
          options.desc = "Location List";
        }
        {
          action = mkAction "marks";
          key = prefix + "m";
          options.desc = "Marks";
        }
        {
          action = mkAction "man";
          key = prefix + "M";
          options.desc = "Manpages";
        }
        {
          action = mkAction "notifications";
          key = prefix + "n";
          options.desc = "Notification History";
        }
        {
          action = mkAction "qflist";
          key = prefix + "q";
          options.desc = "Quickfix List";
        }
        {
          action = mkAction "registers";
          key = prefix + "r";
          options.desc = "Registers";
        }
        {
          action = mkAction "undo";
          key = prefix + "u";
          options.desc = "Undo History";
        }
        {
          action = mkAction "colorschemes";
          key = prefix + "t";
          options.desc = "Colorschemes";
        }
      ]
    );
  };
}
