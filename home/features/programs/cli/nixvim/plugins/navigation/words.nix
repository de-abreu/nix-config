{
  programs.nixvim.plugins.snacks.settings.words = {
    enabled = true;
    debounce = 100;
    foldopen = true;
    jumplist = true;

    filter.__raw =
      # lua
      ''
        function(buf)
          if vim.g.snacks_words == false or vim.b[buf].snacks_words == false then
            return false
          end

          -- Exclude filetypes (match illuminate denylist)
          local ft = vim.bo[buf].filetype
          local deny_filetypes = {
            "dirvish",
            "fugitive",
            "neo-tree",
            "nvim-tree",
            "TelescopePrompt",
          }
          for _, denied_ft in ipairs(deny_filetypes) do
            if ft == denied_ft then
              return false
            end
          end

          -- Disable for large files (match illuminate's 3000 line cutoff)
          local line_count = vim.api.nvim_buf_line_count(buf)
          if line_count > 3000 then
            return false
          end

          return true
        end
      '';
  };
}
