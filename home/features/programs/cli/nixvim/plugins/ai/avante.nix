{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim.extraPlugins = [
    {
      plugin = pkgs.vimPlugins.blink-cmp-avante;
      optional = true;
    }
  ];

  extra.lz-n.plugins = [
    {
      __unkeyed-1 = "blink-cmp-avante";
      event = [
        "InsertEnter"
        "CmdlineEnter"
      ];
    }
  ];

  programs.nixvim.plugins = {
    avante = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";

      settings =
        let
          opencode = config.programs.opencode;
          snacks = config.programs.nixvim.plugins.snacks;
        in
        {
          selector.provider = lib.mkIf snacks.enable "snacks";
        }
        // (lib.optionalAttrs opencode.enable {
          provider = "opencode";
          acp_providers."opencode" = {
            command = "opencode";
            args = [ "acp" ];
            env.OPENCODE_API_KEY.__raw = "os.getenv('OPENCODE_API_KEY')";
          };
        });
    };

    render-markdown = {
      lazyLoad.settings.ft = [ "Avante" ];
      settings.file_types = [ "Avante" ];
    };
  };
}
