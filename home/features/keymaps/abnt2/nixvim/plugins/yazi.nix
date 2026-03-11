{
  lib,
  pluginCfg,
  ...
}: {
  programs.nixvim.keymaps =
    lib.optionals
    pluginCfg.yazi.enable
    (map (m: m // {mode = "n";}) [
      {
        key = "<leader>te";
        action = "<cmd>Yazi<cr>";
        options = {
          desc = "Open Yazi at the current file";
          silent = true;
        };
      }
      {
        key = "<leader>tw";
        action = "<cmd>Yazi cwd<cr>";
        options.desc = "Open Yazi at nvim's cwd";
      }
      {
        key = "<leader>uy";
        action = "<cmd>Yazi toggle<cr>";
        options.desx = "Resume previous Yazi session";
      }
    ]);
}
