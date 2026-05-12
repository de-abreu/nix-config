{
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = [ "R" "b" ];
      run = "plugin recycle-bin";
      desc = "Trash options";
    }
    {
      on = "u";
      run = "plugin restore";
      desc = "Undo deletions";
    }
  ];
}
