{
  config,
  lib,
  options,
  ...
}:
{
  config = lib.mkIf (options ? programs.nixvim) {
    programs.nixvim.keymaps =
      let
        cfg = config.programs.nixvim.plugins.markdown-preview;
      in
      lib.mkIf cfg.enable [
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
  };
}
