{flakePath, ...}: {
  programs.yazi.keymap = let
    common = [
      {
        on = "k";
        run = "arrow 1";
        desc = "Move cursor down";
      }
      {
        on = "l";
        run = "arrow -1";
        desc = "Move cursor up";
      }
    ];
  in {
    mgr.prepend_keymap =
      common
      ++ [
        # Navigation
        {
          on = "j";
          run = "leave";
          desc = "Go to parent directory";
        }
        {
          on = "ç";
          run = "enter";
          desc = "Enter child directory";
        }
        {
          on = "J";
          run = "back";
          desc = "Go to previous directory";
        }
        {
          on = "Ç";
          run = "forward";
          desc = "Go to next directory";
        }

        # Seeking
        {
          on = "K";
          run = "seek 5";
          desc = "Seek down 5 units in the preview";
        }
        {
          on = "L";
          run = "seek -5";
          desc = "Seek up 5 units in the preview";
        }
        {
          on = "h";
          run = "hidden toggle";
          desc = "Toggle the visibility of hidden files";
        }

        # Shortcuts
        {
          on = ["g" "n"];
          run = "cd ${flakePath}";
          desc = "Go to Nix configuration";
        }
      ];
    tasks.prepend_keymap = common;
    spot.prepend_keymap =
      common
      ++ [
        {
          on = "j";
          run = "swipe -1";
          desc = "Swipe to next file";
        }
        {
          on = "ç";
          run = "swipe 1";
          desc = "Swipe to previous file";
        }
      ];
    pick.prepend_keymap = common;
    input.prepend_keymap = [
      {
        on = "j";
        run = "move -1";
        desc = "Move back a character";
      }
      {
        on = "ç";
        run = "move 1";
        desc = "Move forward a character";
      }
    ];
    confirm.prepend_keymap = common;
    cmp.prepend_keymap = [
      {
        on = "<C-k>";
        run = "arrow 1";
        desc = "Move cursor down";
      }
      {
        on = "<C-l>";
        run = "arrow -1";
        desc = "Move cursor up";
      }
    ];
    help.prepend_keymap =
      common
      ++ [
        {
          on = "/";
          run = "filter";
          desc = "Apply filter to help items";
        }
      ];
  };
}
