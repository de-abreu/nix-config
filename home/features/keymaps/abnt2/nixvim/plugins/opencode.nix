{ config, lib, ... }:
let
  cfg = config.programs.nixvim.plugins.opencode;
  prefix = "<leader>a";
in
{
  programs.nixvim = {
    plugins.snacks.settings.picker = lib.mkIf cfg.enable {
      actions.opencode_send.__raw = "function(...) return require('opencode').snacks_picker_send(...) end";
      win.input.keys."<M-a>" = {
        __unkeyed-1 = "opencode_send";
        mode = [
          "n"
          "i"
          "x"
        ];
      };
    };

    plugins.which-key.settings.spec = lib.mkIf cfg.enable [
      {
        __unkeyed-1 = prefix;
        mode = "n";
        group = "Opencode";
        icon = "󱙺";
      }
    ];

    plugins.opencode.lazyLoad.settings.keys = [
      {
        __unkeyed-1 = prefix + "t";
        __unkeyed-2.__raw = "function() require('opencode').toggle() end";
        mode = "n";
        desc = "Toggle window";
      }

      {
        __unkeyed-1 = prefix + "a";
        __unkeyed-2.__raw = "function() require('opencode').ask('@this: ', {submit = true}) end";
        mode = [
          "n"
          "x"
        ];
        desc = "Ask";
      }

      {
        __unkeyed-1 = prefix + "s";
        __unkeyed-2.__raw = "function() require('opencode').select() end";
        mode = [
          "n"
          "x"
        ];
        desc = "Select Prompt";
      }

      {
        __unkeyed-1 = "go";
        __unkeyed-2.__raw = "function() return require('opencode').operator('@this') end";
        mode = [
          "n"
          "x"
        ];
        desc = "Add range to opencode";
        expr = true;
      }

      {
        __unkeyed-1 = "goo";
        __unkeyed-2.__raw = "function() return require('opencode').operator('@this ') .. '_' end";
        mode = "n";
        desc = "Add line to opencode";
        expr = true;
      }

      {
        __unkeyed-1 = "<M-u>";
        __unkeyed-2.__raw = "function() require('opencode').command('session.half.page.up') end";
        mode = [
          "n"
          "t"
        ];
        desc = "Scroll opencode up";
      }

      {
        __unkeyed-1 = "<M-d>";
        __unkeyed-2.__raw = "function() require('opencode').command('session.half.page.down') end";
        mode = [
          "n"
          "t"
        ];
        desc = "Scroll opencode down";
      }

      {
        __unkeyed-1 = prefix + "g";
        __unkeyed-2.__raw = "function() require('opencode').command('session.first') end";
        mode = "n";
        desc = "Go to first message";
      }

      {
        __unkeyed-1 = prefix + "G";
        __unkeyed-2.__raw = "function() require('opencode').command('session.last') end";
        mode = "n";
        desc = "Go to last message";
      }

      {
        __unkeyed-1 = prefix + "S";
        __unkeyed-2.__raw = "function() require('opencode').command('session.interrupt') end";
        mode = "t";
        desc = "Interrupt session";
      }

      {
        __unkeyed-1 = prefix + ".";
        __unkeyed-2.__raw = "function() require('opencode').prompt('@buffer', {append = true}) end";
        mode = "n";
        desc = "Add buffer to prompt";
      }

      {
        __unkeyed-1 = prefix + "e";
        __unkeyed-2.__raw = "function() require('opencode').prompt('Explain @this and its context', {submit = true}) end";
        mode = [
          "n"
          "x"
        ];
        desc = "Explain this code";
      }

      {
        __unkeyed-1 = prefix + "n";
        __unkeyed-2.__raw = "function() require('opencode').command('session.new') end";
        mode = "n";
        desc = "New session";
      }
    ];
  };
}
