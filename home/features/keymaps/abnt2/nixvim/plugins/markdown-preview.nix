{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.markdown-preview;
in
{
  programs.nixvim.keymapsOnEvents.FileType = lib.mkIf cfg.enable [
    {
      mode = "n";
      key = "<leader>um";
      action = "<cmd>MarkdownPreviewToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle markdown preview";
      };
    }
  ];
}
