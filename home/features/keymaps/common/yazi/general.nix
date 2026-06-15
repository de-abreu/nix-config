{
  programs.yazi.keymap =
    let
      close = {
        on = "<Esc>";
        run = "close";
        desc = "Cancel input";
      };
    in
    {
      input.prepend_keymap = [ close ];
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
        {
          on = "i";
          run = "filter";
          desc = "filter interactively";
        }
      ]
      ++ [ close ];
      help.prepend_map = [
        {
          on = "/";
          run = "filter";
          desc = "Apply filter";
        }
      ];
    };
}
