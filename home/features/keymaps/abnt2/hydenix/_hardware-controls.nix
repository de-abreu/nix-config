{
  lib,
  osConfig,
  pkgs,
}:
with pkgs;
let
  inherit (lib) optionalString getExe;
  adjustKeyboardBacklight = osConfig.programs.adjustKeyboardBacklight or { enable = false; };
  bctl = "hyde-shell brightnesscontrol";
  monitorToggle = osConfig.programs.monitorToggle or { enable = false; };
  pctl = playerctl;
  screenlock = "${pctl} pause; loginctl lock-session";
  vctl = "hyde-shell volumecontrol";
  vpnToggle = osConfig.programs.openfortivpn or { enable = false; };
in
#hyprlang
''
  $hc=Hardware Controls

  $d=[$hc|Audio]
  binddlt = , XF86AudioMute, $d toggle mute audio, exec, ${vctl} -o m
  binddel = , XF86AudioLowerVolume, $d lower volume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; ${vctl} -o d
  binddel = , XF86AudioRaiseVolume, $d raise volume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; ${vctl} -o i
  binddl  = , F7,$d toggle microphone, exec, ${vctl} -i m

  $d=[$hc|Media]
  binddlt = , XF86AudioPrev, $d play previous media, exec, ${pctl} previous
  binddlt = , XF86AudioPlay, $d toggle pause, exec, ${pctl} play-pause
  binddlt = , XF86AudioPause,$d pause media, exec, ${pctl} play-pause
  binddlt = , XF86AudioNext, $d play next media, exec, ${pctl} next

  $d=[$hc|Brightness]
  ${optionalString adjustKeyboardBacklight.enable "bindd = , 'XF86KbdLightOnOff', $d toggle keyboard backlight, exec, ${getExe adjustKeyboardBacklight.package}"}
  binddel = , XF86MonBrightnessUp, $d increase brightness, exec, ${bctl} i
  binddel = , XF86MonBrightnessDown, $d decrease brightness, exec, ${bctl} d

  $d=[$hc|Power]
  binddlt = , XF86PowerOff, $d suspend, exec, ${screenlock}; systemctl suspend

  ${optionalString monitorToggle.enable ''
    $d=[$hc|Display]
    bindd = , F8, $d toggle mirror/extend, exec, ${getExe monitorToggle.package}
  ''}

  ${optionalString vpnToggle.enable ''
    $d=[$hc|Network]
    bindd = Shift, $printScreen, $d Toggle VPN, exec, ${getExe vpnToggle.package}
  ''}
''
