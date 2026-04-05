# TODO: Merge these AstroNvim keybinds with Akari's
{
  programs.nixvim.plugins.blink-cmp.settings = {
    keymap = {
      preset = "none";
      "<C-Space>" = ["show" "show_documentation" "hide_documentation"];
      "<Up>" = ["select_prev" "fallback"];
      "<Down>" = ["select_next" "fallback"];
      "<C-N>" = ["select_next" "show"];
      "<C-P>" = ["select_prev" "show"];
      "<C-J>" = ["select_next" "fallback"];
      "<C-K>" = ["select_prev" "fallback"];
      "<C-U>" = ["scroll_documentation_up" "fallback"];
      "<C-D>" = ["scroll_documentation_down" "fallback"];
      "<C-e>" = ["hide" "fallback"];
      "<C-.>" = [
        "show"
        "show_documentation"
        "hide_documentation"
      ];
      "<CR>" = ["accept" "fallback"];

      "<Tab>" = [
        "select_next"
        "snippet_forward"
        # Using the global helper defined in extraConfigLuaPre
        {__raw = "function(cmp) if _G.has_words_before() or vim.api.nvim_get_mode().mode == 'c' then return cmp.show() end end";}
        "fallback"
      ];

      "<S-Tab>" = [
        "select_prev"
        "snippet_backward"
        {__raw = "function(cmp) if vim.api.nvim_get_mode().mode == 'c' then return cmp.show() end end";}
        "fallback"
      ];
    };
    cmdline.keymap."<End>" = ["hide" "fallback"];
  };
}
