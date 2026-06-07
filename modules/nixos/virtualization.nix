# NOTE: Enables virtualization through Virtual Box. This configuration was removed because installing/updating Virtual Box on its own was taking me over over 2 hours, severely slowing my system update.
{
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableKvm = true;
      addNetworkInterface = false;
    };
  };
}
