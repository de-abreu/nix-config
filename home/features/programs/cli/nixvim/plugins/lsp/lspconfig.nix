{
  programs.nixvim.plugins.lsp = {
    enable = true;
    capabilities = ''
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
    '';
  };
}
