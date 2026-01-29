{}: {hyprmode ? false}: let
  mod =
    if hyprmode
    then ""
    else "$mainMod";
in
  #hyprlang
  ''
    $wm=Window Management

    $d = [$wm|General Controls]
    bindd = ${mod}, Q, $d close focused window, exec, hyde-shell dontkillsteam
    bindd = ${mod}, Y, $d toogle floating, togglefloating
    bindd = ${mod}, G, $d toggle grouping, togglegroup
    bindd = ${mod}, Z, $d toogle fullscreen, fullscreen
    bindd = ${mod}, P, $d toggle window pinning, exec, hyde-shell windowpin
    bindd = ${mod}, I, $d toggle split orientation, togglesplit

    $d = [$wm|Group Navigation]
    bindd = ${mod}, Left, $d change active group backwards, changegroupactive, b
    bindd = ${mod}, Right, $d change active group forwards, changegroupactive, f

    $d = [$wm|Change Focus]
    bindd = ${mod}, J, $d focus left window, movefocus, l
    bindd = ${mod}, K, $d focus window below, movefocus, u
    bindd = ${mod}, L, $d focus window above, movefocus, d
    bindd = ${mod}, $ccedilla, $d focus right window, movefocus, r

    $d = [$wm|Move Windows]
    bindd = ${mod} Shift, J, $d move window left, movewindoworgroup, l
    bindd = ${mod} Shift, K, $d move window up, movewindoworgroup, u
    bindd = ${mod} Shift, L, $d move window down, movewindoworgroup, d
    bindd = ${mod} Shift, $ccedilla, $d move window right, movewindoworgroup, r
    binddm = ${mod}, mouse:272, $d hold to move window, move window

    $d = [$wm|Resize Active Window]
    bindde = ${mod} Alt, J, $d resize window left, resizeactive, -30 0
    bindde = ${mod} Alt, K, $d resize window down, resizeactive, 0 30
    bindde = ${mod} Alt, L, $d resize window up, resizeactive, 0 -30
    bindde = ${mod} Alt, $ccedilla, $d resize window right, resizeactive, 30 0
    binddm = ${mod}, R, $d hold to resize window, resizewindow
  ''
