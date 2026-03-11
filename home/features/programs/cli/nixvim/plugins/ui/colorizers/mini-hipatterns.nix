{
  programs.nixvim = {
    extraConfigLuaPre =
      # lua
      ''
        _G.in_comment = function(pattern)
          return function(buf_id)
            local cs = vim.bo[buf_id].commentstring
            if cs == nil or cs == "" then cs = '# %s' end

            -- Extract left and right part relative to '%s'
            local left, right = cs:match('^(.*)%%s(.-)$')
            left, right = vim.trim(left), vim.trim(right)

            -- Example output for '/* %s */' commentstring: '^%s*/%*%s*()TODO().*%*/%s*'
            return string.format('^%%s*%s%%s*()%s().*%s%%s*$', vim.pesc(left), pattern, vim.pesc(right))
          end
        end
      '';

    plugins.mini-hipatterns = {
      enable = true;
      settings.highlighters = {
        fixme = {
          pattern.__raw = "_G.in_comment('FIXME')";
          group = "MiniHipatternsFixme";
        };
        hack = {
          pattern.__raw = "_G.in_comment('HACK')";
          group = "MiniHipatternsHack";
        };
        todo = {
          pattern.__raw = "_G.in_comment('TODO')";
          group = "MiniHipatternsTodo";
        };
        note = {
          pattern.__raw = "_G.in_comment('NOTE')";
          group = "MiniHipatternsNote";
        };
      };
    };
  };
}
