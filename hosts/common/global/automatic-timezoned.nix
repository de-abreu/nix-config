{ lib, ... }:
{
  time.timeZone = lib.mkForce null; # INFO: mkForce setups value to be overriden by automatic timezone detection.
  services.automatic-timezoned.enable = true;
}
