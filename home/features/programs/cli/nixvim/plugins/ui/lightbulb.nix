let
  icons = import ./lib/icons.nix;
in {
  programs.nixvim.plugins.nvim-lightbulb = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      autocmd = {
        enabled = true;
        updatetime = 200;
      };

      line = {
        enabled = true;
      };

      number = {
        enabled = true;
      };

      sign = {
        enabled = true;
        text = icons.actionAvailable;
      };

      status_text = {
        enabled = true;
        text = icons.actionAvailable;
      };
    };
  };
}
