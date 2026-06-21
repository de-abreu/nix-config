{
  programs.opencode.settings.permission.bash."sudo *" = "deny";
  xdg.configFile."opencode/instructions/shell_strategy.md".source = ./shell_strategy.md;
}
