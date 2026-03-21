{ config, ... }:
{
  stylix.targets.waybar.enable = false;
  xdg.configFile."waybar/theme.css" = {
    text = with config.lib.stylix.colors.withHashtag; ''
      @define-color bar-bg rgba(0, 0, 0, 0);

      @define-color main-bg ${base00};
      @define-color main-fg ${base06};

      @define-color wb-act-bg ${base0B};
      @define-color wb-act-fg ${base02};

      @define-color wb-hvr-bg ${base08};
      @define-color wb-hvr-fg ${base02};
    '';
    force = true;
  };
}
