{
  featuresEnabled,
  lib,
  pickerAction,
  ...
}: let
  prefix = "<leader>l";
in {
  programs.nixvim.keymaps =
    lib.options
    (featuresEnabled "picker")
    (map (el: el // {mode = "n";}) [
      {
        action = pickerAction "lsp_definitions";
        key = prefix + "d";
        options.desc = "Goto Definition";
      }
      {
        action = pickerAction "lsp_declarations";
        key = prefix + "D";
        options.desc = "Goto Declaration";
      }
      {
        action = pickerAction "lsp_references";
        key = prefix + "r";
        options = {
          desc = "Goto References";
          nowait = true;
        };
      }
      {
        action = pickerAction "lsp_implementations";
        key = prefix + "I";
        options.desc = "Goto Implementation";
      }
      {
        action = pickerAction "lsp_type_definitions";
        key = prefix + "y";
        options.desc = "Goto T[y]pe Definiton";
      }
      {
        action = pickerAction "lsp_incoming_calls";
        key = prefix + "i";
        options.desc = "Incoming calls";
      }
      {
        action = pickerAction "lsp_outgoing_calls";
        key = prefix + "o";
        options.desc = "Outgoing calls";
      }
      {
        action = pickerAction "lsp_symbols";
        key = prefix + "s";
        options.desc = "LSP Symbols";
      }
      {
        action = pickerAction "lsp_workspace_symbols";
        key = prefix + "S";
        options.desc = "LSP Workspace Symbols";
      }
    ]);
}
