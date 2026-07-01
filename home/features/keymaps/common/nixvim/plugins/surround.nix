{ lib, options, ... }:
with lib;
{
  config =
    let
      key = "s";
    in
    mkIf (options ? programs.nixvim) {
      programs.nixvim.plugins = {
        nvim-surround.settings.keymaps = {
          # s{motion}{char} — Add surround around a motion (e.g. siw")
          normal = key;

          # ss{char} — Add surround around the current line, ignoring whitespace (e.g. ss")
          normal_cur = key + key;

          # S{motion}{char} — Add surround around a motion, with delimiters on new lines (e.g. S$")
          normal_line = toUpper key;

          # SS{char} — Add surround around the current line, with delimiters on new lines (e.g. SS")
          normal_cur_line = key + key |> toUpper;

          # s in visual mode — Add surround around the selection (charwise)
          visual = key;

          # S in visual mode — Add surround around the selection, on new lines (linewise)
          visual_line = toUpper key;

          # ds{char} — Delete surrounding delimiters (e.g. ds")
          delete = "d${key}";

          # cs{old}{new} — Change surrounding delimiters (e.g. cs'")
          change = "c${key}";

          # cS{old}{new} — Change surrounding delimiters, placing replacements on new lines
          change_line = "c${toUpper key}";
        };

        cutlass-nvim.settings.exclude = [
          key
          (toUpper key)
        ];
      };
    };
}
