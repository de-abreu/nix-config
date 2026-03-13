# INFO: Otter.nvim provides lsp features, including code completion, for code embedded in other documents
{config, ...}: let
  cfg = config.programs.nixvim.plugins.treesitter;
in {
  programs.nixvim.plugins.otter = {
    inherit (cfg) enable;
    autoActivate = false;

    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      handle_leading_whitespace = true;

      lsp.diagnostic_update_events = [
        "BufWritePost"
        "InsertLeave"
        "TextChanged"
      ];

      buffers.set_filetype = true;
    };
  };
}
