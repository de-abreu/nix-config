{
  programs.nixvim.plugins.nvim-autopairs = {
    enable = true;
    lazyLoad.settings.event = "InsertEnter";

    settings = {
      check_ts = true;
      ts_config.java = false;
      enabled.__raw =
        # lua
        ''
          function(bufnr)
            return vim.api.nvim_buf_is_valid(bufnr)
          end
        '';
      fast_wrap = {
        end_key = "$";
        highlight = "PmenuSel";
        highlight_grey = "LineNr";
      };
    };
  };
}
