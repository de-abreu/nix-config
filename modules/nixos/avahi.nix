# Avahi (mDNS/DNS-SD) enables zero-configuration networking on the local network.
# It allows resolving .local hostnames (e.g., raspberry-2a.local) without a DNS server
# and discovering advertised services like SSH, printers, etc.
#
# This is required for IoT development workflows where devices (Raspberry Pi, etc.)
# are connected directly via ethernet and need to be discovered by hostname.
{ lib, ... }:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
