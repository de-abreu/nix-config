{
  featureEnabled,
  lib,
  pickerAction,
  ...
}: {
  programs.nixvim.keymaps =
    lib.optionals
    (featureEnabled "picker")
    (map (m: m // {mode = "n";}) [
      {
        key = "<leader><space>";
        action = pickerAction "smart";
        options.desc = "Smart Find Files";
      }
      {
        key = "<leader>b<space>";
        action = pickerAction "buffers";
        options.desc = "Search Buffers";
      }
      {
        key = "<leader>:";
        action = pickerAction "command_history";
        options.desc = "Command History";
      }
      {
        key = "<leader>n";
        action = pickerAction "notifications";
        options.desc = "Notification History";
      }
    ]);
}
