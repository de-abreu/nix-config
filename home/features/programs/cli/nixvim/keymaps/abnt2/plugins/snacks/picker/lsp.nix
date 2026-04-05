{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.snacks;
  enable = cfg.enable && ((cfg.settings.picker.enabled or false) == true);
  prefix = "<leader>l";
  mkAction = func: {__raw = "function() Snacks.picker.${func}() end";};
in {
  programs.nixvim.keymaps = lib.mkIf enable (map (el: el // {mode = "n";}) [
    {
      action = mkAction "lsp_definitions";
      key = prefix + "d";
      options.desc = "Goto Definition";
    }
    {
      action = mkAction "lsp_declarations";
      key = prefix + "D";
      options.desc = "Goto Declaration";
    }
    {
      action = mkAction "lsp_references";
      key = prefix + "r";
      options = {
        desc = "Goto References";
        nowait = true;
      };
    }
    {
      action = mkAction "lsp_implementations";
      key = prefix + "I";
      options.desc = "Goto Implementation";
    }
    {
      action = mkAction "lsp_type_definitions";
      key = prefix + "y";
      options.desc = "Goto T[y]pe Definiton";
    }
    {
      action = mkAction "lsp_incoming_calls";
      key = prefix + "i";
      options.desc = "Incoming calls";
    }
    {
      action = mkAction "lsp_outgoing_calls";
      key = prefix + "o";
      options.desc = "Outgoing calls";
    }
    {
      action = mkAction "lsp_symbols";
      key = prefix + "s";
      options.desc = "LSP Symbols";
    }
    {
      action = mkAction "lsp_workspace_symbols";
      key = prefix + "S";
      options.desc = "LSP Workspace Symbols";
    }
  ]);
}
