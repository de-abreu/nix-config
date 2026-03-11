let
  icons = import ./lib/icons.nix;
in {
  programs.nixvim = {
    plugins.dap.settings.signs = with icons.dap; {
      dapBreakpoint = {
        text = breakpoint.default;
        texthl = "DiagnosticInfo";
      };
      dapBreakpointCondition = {
        text = breakpoint.condition;
        texthl = "DiagnosticInfo";
      };
      dapBreakpointRejected = {
        text = breakpoint.rejected;
        texthl = "DiagnosticError";
      };
      dapLogPoint = {
        text = logpoint;
        texthl = "DiagnosticInfo";
      };
      dapStopped = {
        text = stopped;
        texthl = "DiagnosticWarn";
        linehl = "DapStoppedLine";
        numhl = "DapStoppedLine";
      };
    };
  };
}
