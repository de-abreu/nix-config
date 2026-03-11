{
  programs.nixvim.plugins.better-escape = {
    enable = true;
    lazyLoad.settings.event = [
      "InsertEnter"
      "TermEnter"
    ];

    settings.timeout = 300;
  };
}
