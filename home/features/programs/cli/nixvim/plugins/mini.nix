{lib, ...}: {
  programs.nixvim.plugins = lib.genAttrs [
    "mini-splitjoin"
    "mini-surround"
  ] (_: {enabled = true;});
}
