# INFO: Python type checking with BasedPyright
# BasedPyright is a fork of Pyright with additional features
{
  programs.nixvim.lsp.servers.basedpyright = {
    enable = true;
    config = {
      basedpyright = {
        analysis = {
          # Type checking mode: off, basic, standard, strict
          typeCheckingMode = "basic";

          # Auto-import completions
          autoImportCompletions = true;

          # Diagnostic severity overrides - reduce noise
          diagnosticSeverityOverrides = {
            reportUnusedImport = "information";
            reportUnusedFunction = "information";
            reportUnusedVariable = "information";
            reportGeneralTypeIssues = "none";
            reportOptionalMemberAccess = "none";
            reportOptionalSubscript = "none";
            reportPrivateImportUsage = "none";
          };
        };
      };
    };
  };
}
