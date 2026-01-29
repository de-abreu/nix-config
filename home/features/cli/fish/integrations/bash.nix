# INFO: Retain Bash as the login shell, but switch to fish when in an interactive shell session. See: https://nixos.wiki/wiki/Fish
{...}: {
  programs.bash = {
    enable = true;
    initExtra =
      # bash
      ''
        # Check if fish is installed
        if command -v fish > /dev/null &&
        # Allow bash to be called from within a fish shell (by preventing looping back to fish)
        [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" &&
        # Allow bash commands (e.g. bash -c "echo hello") to be called from within a fish shell
        -z ''${BASH_EXECUTION_STRING} ]]
          then
          # Check if the current shell is a login shell and set the login options for fish
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec fish $LOGIN_OPTION
        fi
      '';
  };
}
