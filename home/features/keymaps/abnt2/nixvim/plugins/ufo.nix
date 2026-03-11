{
  lib,
  pluginCfg,
  ...
}: {
  programs.nixvim = {
    plugins.nvim-ufo.settings.preview.mappings = {
      close = "q";
      switch = "K";
    };

    keymaps = lib.optionals pluginCfg.ufo.enable [
      {
        mode = "n";
        key = "zR";
        action.__raw = "function() require('ufo').openAllFolds() end";
        options.desc = "Open all folds";
      }
      {
        mode = "n";
        key = "zM";
        action.__raw = "function() require('ufo').closeAllFolds() end";
        options.desc = "Close all folds";
      }
      {
        mode = "n";
        key = "zK";
        action.__raw =
          # lua
          ''
            function()
              if not require('ufo').peekFoldedLinesUnderCursor() then
                vim.lsp.buf.hover()
              end
            end
          '';
        options.desc = "Peek Folded Lines or Hover";
      }
    ];
  };
}
