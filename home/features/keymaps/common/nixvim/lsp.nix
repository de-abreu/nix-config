{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.lsp;
  prefix = "<leader>l";
in
{
  programs.nixvim = {
    keymapsOnEvents.LspAttach = lib.mkIf cfg.enable [
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

      {
        mode = "n";
        key = prefix + "Q";
        action = "<cmd>LspInfo<cr>";
        options.desc = "Lsp Info";
      }
    ];

    lsp.servers.clangd.config.onAttach.function =
      # lua
      ''
        vim.keymap.set(
          'n',
          'gh',
          "<cmd>ClangdSwitchSourceHeader<cr>",
          {
            desc = "Switch Source/Header (C/C++)",
            buffer = bufnr
          }
        )
      '';

    plugins.which-key.settings.spec = lib.optional cfg.enable [
      {
        __unkeyed-1 = prefix;
        group = "LSP";
        icon = " ";
        mode = [
          "n"
          "v"
        ];
      }
    ];
  };
}
