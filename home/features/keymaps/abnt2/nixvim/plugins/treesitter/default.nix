{importAll, ...}: {
  imports = importAll {dir = ./.;};
  programs.nixvim.plugins.treesitter.settings.incremental_selection.keymaps = {
    init_selection = "<A-o>";
    node_incremental = "<A-o>";
    scope_incremental = "<A-O>";
    node_decremental = "<A-i>";
  };
}
