{
  programs.nixvim.plugins = {
    dap = {
      enable = true;

      # Load when any of these Neovim commands are executed
      lazyLoad.settings.cmd = [
        "DapContinue"
        "DapStepOver"
        "DapStepInto"
        "DapStepOut"
        "DapToggleBreakpoint"
        "DapToggleRepl"
        "DapTerminate"
      ];
    };

    blink-cmp.settings.sources.providers.dap = {
      name = "dap";
      module = "blink.compat.source";
      score_offset = 100;
    };
  };
}
