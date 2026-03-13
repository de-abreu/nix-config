{ importAll, ... }:
{
  imports = importAll {
    dir = ./.;
    exclude = [ "bilateral-shift.nix" ];
  };
  console.keyMap = "br-abnt2";
}
