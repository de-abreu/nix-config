{pkgs, ...}: {
  programs.fish.plugins =
    (map
      (plugin: {
        name = "${plugin}";
        inherit (pkgs.fishPlugins."${plugin}") src;
      }) [
        "autopair"
        # INFO: Automatically closes pairs of symbols such as "", (), [], etc.

        "bang-bang"
        # INFO: Typing "!$" repeats the previous command, while "!!" only its last argument

        "colored-man-pages"
        # INFO: Highlight the text displayed using the "man" command

        "done"
        # INFO: Emit a notification when a command with a long execution time finishes.

        "fish-bd"
        # INFO: Adds the "bd" command to navigate to parent folders

        "fish-you-should-use"
        # INFO: Suggest abbreviations and aliases when available

        "fzf-fish" # TODO: List fzf keybindings into a cheatsheet solution for the terminal
        # INFO: Use fuzzy finding to perform a variety of operations

        "git-abbr"
        # INFO: Add git abbreviations

        "sponge"
        # INFO: Automatically exclude errors from the command history
      ])
    ++ [
      {
        # INFO: Add a ssh key to the ssh-agent through the "ssh-add" command.
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "f10d95775352931796fd17f54e6bf2f910163d1b";
          hash = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
        };
      }
    ];
}
