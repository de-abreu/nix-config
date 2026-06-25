{
  config,
  lib,
  pkgs,
}:
{
  hyprmode ? false,
}:
let
  mod = if hyprmode then "" else "$mainMod";
  screenRecorder = config.programs.wfrc or { enable = false; };
  filebrowser = config.home.sessionVariables.FILEBROWSER or "yazi";
  browser = config.home.sessionVariables.BROWSER or "firefox";
  terminal = config.home.sessionVariables.TERMINAL or "kitty";
  sysMonitor = config.home.sessionVariables.SYS_MONITOR or "htop";
  cheatsheetCmd =
    let
      cs = config.programs.cheatsheet;
    in
    if (cs.enable or false) then
      lib.getExe cs.package
    else
      "pkill -x rofi || hyde-shell keybinds_hint c";
in
#hyprlang
''
  $l=Launchers

  $d = [$l|Menus]
  $rofi-launch=hyde-shell rofilaunch
  bindd = ${mod}, space, $d Application finder, exec, $toDefault; pkill -x rofi || $rofi-launch d
  bindd = ${mod}, TAB, $d Window switcher, exec, $toDefault; pkill -x rofi || $rofi-launch w
  bindd = ${mod}, slash, $d Keybind cheatsheet, exec, $toDefault; ${cheatsheetCmd}
  bindd = ${mod}, comma, $d Emoji picker, exec, $toDefault; pkill -x rofi || hyde-shell emoji-picker
  bindd = ${mod}, period, $d Gliph picker, exec, $toDefault; pkill -x rofi || hyde-shell glyph-picker
  bindd = ${mod}, V, $d Clipboard history, exec, $toDefault; pkill -x rofi || hyde-shell cliphist -c
  bindd = ${mod} Shift, space, $d Menu layout options, exec, $toDefault; pkill -x rofi || hyde-shell rofiselect
  bindd = ${mod}, $apostrophe, $d Power options, exec, $toDefault; pkill -x rofi || hyde-shell logoutlaunch

  $d = [$l|Shortcuts]
  bindd = ${mod}, T, $d open terminal, exec, $toDefault; ${terminal}
  bindd = ${mod} Control, T, $d Toggle dropdown terminal, exec, $toDefault; hyde-shell pypr console
  bindd = ${mod}, E, $d open file explorer, exec, $toDefault; ${filebrowser}
  bindd = ${mod}, B, $d open web browser, exec, $toDefault; ${browser}
  bindd = ${mod}, S, $d open system monitor, exec, $toDefault; ${sysMonitor}
  bindd = ${mod} Shift, G, $d open game launcher , exec, $toDefault; hyde-shell gamelauncher # run game launcher for steam and lutris
  bindd = ${mod} Alt, G, $d game mode , exec, $toDefault; hyde-shell gamemode # disable hypr effects for gamemode
  ${lib.optionalString (screenRecorder.enable or false)
    # hyprlang
    ''
      bindd = ${mod}, R, $d record the screen, exec, $toDefault; WFRC_FULL_SCREEN=1 ${lib.getExe screenRecorder.package}
      bindd = ${mod} Shift, R, $d record a portion of the screen, exec, $toDefault; ${lib.getExe screenRecorder.package}
    ''
  }
  ${lib.optionalString (pkgs ? screenshot)
    # hyprlang
    ''
      bindd = , $printScreen, $d take a screenshot, exec, $toDefault; ${lib.getExe pkgs.screenshot}
    ''
  }
''
