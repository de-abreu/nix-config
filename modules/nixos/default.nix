{ inputs, ... }:
let
  tree = inputs.import-tree;
in
{
  # virtualization = import ./virtualization.nix;
  adjust-kbd-backlight = tree [ ./adjust-kbd-backlight ];
  avahi = import ./avahi.nix;
  kanata = tree [ ./kanata ];
  monitor-toggle = tree [ ./monitor-toggle ];
  nh = import ./nh.nix;
  openfortivpn = tree [ ./openfortivpn ];
}
