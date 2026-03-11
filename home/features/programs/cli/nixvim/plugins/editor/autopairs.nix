{
  programs.nixvim.plugins.nvim-autopairs = {
    enable = true;
    lazyLoad.settings.event = "InsertEnter";

    settings = {
      check_ts = true;
      ts_config.java = false;
      enabled =
        # lua
        ''
          function(bufnr)
            return vim.api.nvim_buf_is_valid(bufnr)
          end
        '';
      fast_wrap = {
        chars = ["{" "[" "(" "\"" "'"];
        pattern = "[%'%\"%)%>%]%\)%}%,]";
        offset = 0;
        end_key = "$";
        check_comma = true;
        highlight = "PmenuSel";
        highlight_grey = "LineNr";
      };
    };
  };
}
