{
  programs.nixvim = {
    plugins.hardtime.settings = {
      disabled_keys = {
        "<Up>".__raw = "{ }";
        "<Down>".__raw = "{ }";
        "<Left>".__raw = "{ }";
        "<Right>".__raw = "{ }";
      };
      restricted_keys = {
        "<Up>" = [ "" ];
        "<Down>" = [ "" ];
        "<Left>" = [ "" ];
        "<Right>" = [ "" ];
      };
    };

    keymaps = [
      {
        action = "v:count == 0? 'gj' : 'j'";
        key = "k";
        options = {
          desc = "Move cursor down";
          expr = true;
          silent = true;
        };
        mode = [
          "n"
          "o"
          "x"
        ];
      }

      {
        action = "v:count == 0? 'gk' : 'k'";
        key = "l";
        options = {
          desc = "Move cursor up";
          expr = true;
          silent = true;
        };
        mode = [
          "n"
          "o"
          "x"
        ];
      }

      {
        action = "h";
        key = "j";
        options = {
          desc = "Move cursor left";
          silent = true;
        };
        mode = [
          "n"
          "o"
          "x"
        ];
      }

      {
        action = "l";
        key = "ç";
        options = {
          desc = "Move cursor right";
          silent = true;
        };
        mode = [
          "n"
          "o"
          "x"
        ];
      }

      {
        action = "gg^";
        key = "gg";
        options.desc = "Move cursor to the first character";
        mode = [
          "n"
          "o"
          "x"
        ];
      }

      {
        action = "GG$";
        key = "G";
        options.desc = "Move cursor to the last character";
        mode = [
          "n"
          "o"
          "x"
        ];
      }

      {
        action = "g^";
        key = "^";
        options.desc = "Move cursor to the first character linewise";
        mode = [
          "n"
          "o"
          "x"
        ];
      }

      {
        action = "g0";
        key = "0";
        options.desc = "Move cursor to the beggining of the line";
        mode = [
          "n"
          "o"
          "x"
        ];
      }

      {
        action = "g$";
        key = "$";
        options.desc = "Move cursor to the end of the line";
        mode = [
          "n"
          "o"
          "x"
        ];
      }
    ];
  };
}
