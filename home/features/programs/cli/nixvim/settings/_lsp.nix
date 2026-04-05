{
  inlayHints.enable = true;

  servers = {
    "*".config = {
      capabilities.textDocument.semanticTokens.multilineTokenSupport = true;
      root_markers = [ ".git" ];
    };

    typos_lsp = {
      enable = true;
      config = {
        init_options.diagnosticSeverity = "Hint";
        filetypes = [
          "markdown"
          "text"
          "gitcommit"
          "gitrebase"
          "mail"
        ];
      };
    };
  };
}
