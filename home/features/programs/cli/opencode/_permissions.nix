# INFO: Workaround for plan mode security bypass (issue #24741)
# Prevents subagents spawned from a restricted parent (e.g. plan) from
# inheriting default permissive permissions. See:
# https://github.com/anomalyco/opencode/issues/24741
{
  programs.opencode.settings = {
    permission = {
      edit = "ask";
      task = {
        "*" = "ask";
        explore = "allow";
      };
    };
    agent = {
      build.permission = {
        edit."*" = "allow";
        task.general = "allow";
      };
      general.permission = {
        edit."*" = "allow";
        task.general = "allow";
      };
      plan.permission.edit = "deny";
    };
  };
}

