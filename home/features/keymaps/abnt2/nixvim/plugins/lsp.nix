{
  pluginCfg,
  lib,
  ...
}: let
  prefix = "<leader>l";
in {
  programs.nixvim.plugins = {
    lsp.keymapsOnEvents.LspAttach = lib.optionals pluginCfg.lsp.enable [
      {
        key = prefix + "H";
        mode = "n";
        action.__raw = "vim.diagnostic.open_float";
        options = {
          silent = true;
          desc = "Lsp diagnostic open_float";
        };
      }

      {
        key = prefix + "a";
        mode = "n";
        action.__raw = "vim.lsp.buf.code_action";
        options = {
          silent = true;
          desc = "Lsp buf code_action";
        };
      }
    ];

    which-key.settings.spec = lib.optional pluginCfg.lsp.enable [
      {
        __unkeyed-1 = prefix;
        group = "LSP";
        icon = " ";
        mode = ["n" "v"];
      }
    ];

    keymaps = lib.optionals pluginCfg.lsp.enable [
      {
        mode = "n";
        key = prefix + "Q";
        action = "<cmd>LspInfo<cr>";
        options.desc = "Lsp Info";
      }
    ];
  };
}
