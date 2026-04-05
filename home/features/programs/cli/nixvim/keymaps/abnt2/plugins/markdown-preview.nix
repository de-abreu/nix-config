{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.markdown-preview;
in
{
  programs.nixvim.keymaps = lib.mkIf cfg.enable [
    {
      mode = "n";
      key = "<leader>uM";
      action = "<cmd>MarkdownPreviewToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle markdown preview";
      };
    }
  ];
}
