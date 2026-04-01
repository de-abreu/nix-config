{
  config,
  lib,
  pkgs,
  ...
}:
let
  envVar = "GITHUB_PERSONAL_ACCESS_TOKEN";
  secretsPath = "api-keys/github";
  inherit (config.sops) secrets;

  writeTools = [
    "github_create_or_update_file"
    "github_delete_file"
    "github_push_files"
    "github_create_repository"
    "github_fork_repository"
    "github_create_branch"
    "github_issue_write"
    "github_add_issue_comment"
    "github_sub_issue_write"
    "github_create_pull_request"
    "github_update_pull_request"
    "github_merge_pull_request"
    "github_update_pull_request_branch"
    "github_pull_request_review_write"
    "github_add_comment_to_pending_review"
    "github_assign_copilot_to_issue"
    "github_request_copilot_review"
  ];
in
{
  sops.secrets."api-keys/github" = { };

  programs = {
    fish.shellInit =
      # fish
      ''
        export ${envVar}=(cat ${secrets.${secretsPath}.path})
      '';

    opencode.settings = {
      permission = lib.genAttrs writeTools (_: "deny");
      agent.build.permission = lib.genAttrs writeTools (_: "allow");
    };

    mcp.servers.github = {
      command = lib.getExe pkgs.github-mcp-server;
      args = [ "stdio" ];
      env.GITHUB_PERSONAL_ACCESS_TOKEN = "{env:${envVar}}";
    };
  };
}
