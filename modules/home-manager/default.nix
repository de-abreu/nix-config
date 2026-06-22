{ inputs, ... }:
let
  tree = inputs.import-tree;
in
{
  cheatsheet = tree [ ./cheatsheet ];
  stylix_presenterm = import ./stylix/presenterm;
  presenterm = tree [ ./presenterm ];
  qalculate = import ./qalculate;
  wezterm-override = tree [ ./wezterm-override ];
  wfrc = tree [ ./wfrc ];
}
