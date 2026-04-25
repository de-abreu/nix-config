{ pkgs, lib, ... }:

# INFO: Python language support - base configuration
# Includes DAP debugging, virtual environment management, and type checking
{
  programs.nixvim = {
    # Mypy for additional type checking
    plugins.lint = {
      lintersByFt.python = [ "mypy" ];
      linters.mypy = {
        cmd = lib.getExe pkgs.mypy;
        args = [ "--ignore-missing-imports" ];
      };
    };

    plugins = {
      dap-python = {
        enable = true;
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

      venv-selector = {
        enable = true;
        lazyLoad.settings.cmd = [ "VenvSelect" ];
      };
    };
  };
}
