let
  icons = import ./_icons.nix;
in {
  programs.nixvim.plugins.snacks.settings.notifier = {
    enable = true;
    icons = with icons; {
      debug = debugger;
      error = diagnostic.error;
      info = diagnostic.info;
      trace = diagnostic.hint;
      warn = diagnostic.warn;
    };
  };
}
