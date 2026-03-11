{
  programs.nixvim.plugins.better-escape = {
    settings = {
      default_mappings = false;
      mappings = {
        i = {
          j = {
            "ç" = "<Esc>";
          };
          "ç" = {
            j = "<Esc>";
            "ç" = "<Esc>";
          };
        };
        t."ç"."ç" = "<C-\\><C-n>";
      };
    };
  };
}
