{
  featuresEnabled,
  lib,
  pickerAction,
  ...
}: let
  prefix = "<leader>s";
in {
  programs.nixvim = {
    plugins.which-key.settings.spec = lib.optionals (featuresEnabled "picker") [
      {
        __unkeyed-1 = prefix;
        mode = "n";
        group = "Search";
      }
    ];

    keymaps =
      lib.optionals
      (featuresEnabled "picker")
      (map (el: el // {mode = "n";}) [
        {
          action = pickerAction "resume";
          key = prefix + "<space>";
          options.desc = "Resume";
        }
        {
          action = pickerAction "search_history";
          key = prefix + "/";
          options.desc = "Search History";
        }
        {
          action = pickerAction "autocmds";
          key = prefix + "a";
          options.desc = "Autocmds";
        }
        {
          action = pickerAction "lines";
          key = prefix + "b";
          options.desc = "Buffer lines";
        }
        {
          action = pickerAction "command_history";
          key = prefix + "c";
          options.desc = "Command History";
        }
        {
          action = pickerAction "commands";
          key = prefix + "C";
          options.desc = "Commands";
        }
        {
          action = pickerAction "diagnostics";
          key = prefix + "D";
          options.desc = "Diagnostics";
        }
        {
          action = pickerAction "diagnostics_buffer";
          key = prefix + "d";
          options.desc = "Buffer Diagnostics";
        }
        {
          action = pickerAction "help";
          key = prefix + "h";
          options.desc = "Help Pages";
        }
        {
          action = pickerAction "highlights";
          key = prefix + "H";
          options.desc = "Highlights";
        }
        {
          action = pickerAction "icons";
          key = prefix + "i";
          options.desc = "Icons";
        }
        {
          action = pickerAction "jumps";
          key = prefix + "j";
          options.desc = "Jumps";
        }
        {
          action = pickerAction "keymaps";
          key = prefix + "k";
          options.desc = "Keymaps";
        }
        {
          action = pickerAction "loclist";
          key = prefix + "l";
          options.desc = "Location List";
        }
        {
          action = pickerAction "marks";
          key = prefix + "m";
          options.desc = "Marks";
        }
        {
          action = pickerAction "man";
          key = prefix + "M";
          options.desc = "Manpages";
        }
        {
          action = pickerAction "qflist";
          key = prefix + "q";
          options.desc = "Quickfix List";
        }
        {
          action = pickerAction "registers";
          key = prefix + "r";
          options.desc = "Registers";
        }
        {
          action = pickerAction "undo";
          key = prefix + "u";
          options.desc = "Undo History";
        }
        {
          action = pickerAction "colorschemes";
          key = prefix + "t";
          options.desc = "Colorschemes";
        }
      ]);
  };
}
