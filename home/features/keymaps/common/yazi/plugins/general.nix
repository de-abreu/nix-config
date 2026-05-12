{ flakePath, ... }:
{
  programs.yazi.keymap.mgr.prepend_keymap = [
    # Shortcuts
    {
      on = [ "g" "n" ];
      run = "cd ${flakePath}";
      desc = "Go to Nix configuration";
    }

    # Issuing commands
    {
      on = "!";
      for = "unix";
      run = ''shell "$SHELL" --block'';
      desc = "Open $SHELL here";
    }
  ];
}
