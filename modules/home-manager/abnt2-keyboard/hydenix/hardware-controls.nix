{pkgs}:
with pkgs; let
  bctl = "hyde-shell brightnesscontrol";
  pctl = playerctl;
  vctl = "hyde-shell volumecontrol";
  screenlock = "${pctl} pause; loginctl lock-session";
in
  #hyprlang
  ''
    $hc=Hardware Controls

    $d=[$hc|Audio]
    binddlt = , XF86AudioMute, $d toggle mute audio, exec, ${vctl} -o m
    binddel = , XF86AudioLowerVolume, $d lower volume, exec, ${vctl} -o d
    binddel = , XF86AudioRaiseVolume, $d raise volume, exec, ${vctl} -o i
    binddl  = , F7,$d toggle microphone, exec, ${vctl} -i m

    $d=[$hc|Media]
    binddlt = , XF86AudioPrev, $d play previous media, exec, ${pctl} previous
    binddlt = , XF86AudioPlay, $d toggle pause, exec, ${pctl} play-pause
    binddlt = , XF86AudioPause,$d pause media, exec, ${pctl} play-pause
    binddlt = , XF86AudioNext, $d play next media, exec, ${pctl} next

    $d=[$hc|Brightness]
    bindd = , "XF86KbdLightOnOff", $d toggle keyboard backlight, exec, adjust_kbd_backlight
    binddel = , XF86MonBrightnessUp, $d increase brightness, exec, ${bctl} i
    binddel = , XF86MonBrightnessDown, $d decrease brightness, exec, ${bctl} d

    $d=[$hc|Power]
    binddlt = , XF86PowerOff, $d suspend, exec, ${screenlock}; systemctl suspend
  ''
