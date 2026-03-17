{ lib, ... }:
{
  time.timeZone = lib.mkForce null;
  services.automatic-timezoned.enable = true;
}
