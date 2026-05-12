{
  programs.yazi.keymap = {
    input.prepend_keymap = [
      {
        on = "<Esc>";
        run = "close";
        desc = "Cancel input";
      }
    ];
    mgr.prepend_keymap = [
      {
        on = "\\";
        run = "tab_create";
        desc = "Create new tab here";
      }
      {
        on = ["f" "k"];
        run = "help";
        desc = "Keymaps";
      }
    ];
    help.prepend_map = [
      {
        on = "/";
        run = "filter";
        desc = "Apply filter";
      }
    ];
  };
}
