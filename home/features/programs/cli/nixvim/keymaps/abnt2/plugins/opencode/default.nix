{ config, lib, ... }:
let
  cfg = config.programs.nixvim.plugins.opencode;
  prefix = "<leader>a";
in
{
  programs.nixvim.keymaps = lib.mkIf cfg.enable [
    {
      key = prefix + "t";
      action.__raw = "function() require('opencode').toggle() end";
      mode = "n";
      options.desc = "Toggle window";
    }

    {
      key = prefix + "a";
      action.__raw = "function() require('opencode').ask('@this: ', {submit = true}) end";
      mode = [
        "n"
        "x"
      ];
      options.desc = "Ask";
    }

    {
      key = prefix + "s";
      action.__raw = "function() require('opencode').select() end";
      mode = [
        "n"
        "x"
      ];
      options.desc = "Select Prompt";
    }

    {
      key = "go";
      action.__raw = "function() return require('opencode').operator('@this') end";
      mode = [
        "n"
        "x"
      ];
      options = {
        desc = "Add range to opencode";
        expr = true;
      };
    }

    {
      key = "goo";
      action.__raw = "function() return require('opencode').operator('@this ') .. '_' end";
      mode = "n";
      options = {
        desc = "Add line to opencode";
        expr = true;
      };
    }

    {
      key = "<M-u>";
      action.__raw = "function() require('opencode').command('session.half.page.up') end";
      mode = [
        "n"
        "t"
      ];
      options.desc = "Scroll opencode up";
    }

    {
      key = "<M-d>";
      action.__raw = "function() require('opencode').command('session.half.page.down') end";
      mode = [
        "n"
        "t"
      ];
      options.desc = "Scroll opencode down";
    }

    {
      key = prefix + "g";
      action.__raw = "function() require('opencode').command('session.first') end";
      mode = "n";
      options.desc = "Go to first message";
    }

    {
      key = prefix + "G";
      action.__raw = "function() require('opencode').command('session.last') end";
      mode = "n";
      options.desc = "Go to last message";
    }

    {
      key = prefix + "S";
      action.__raw = "function() require('opencode').command('session.interrupt') end";
      mode = "t";
      options.desc = "Interrupt session";
    }

    {
      key = prefix + ".";
      action.__raw = "function() require('opencode').prompt('@buffer', {append = true}) end";
      mode = "n";
      options.desc = "Add buffer to prompt";
    }

    {
      key = prefix + "e";
      action.__raw = "function() require('opencode').prompt('Explain @this and its context', {submit = true}) end";
      mode = [
        "n"
        "x"
      ];
      options.desc = "Explain this code";
    }

    {
      key = prefix + "n";
      action.__raw = "function() require('opencode').command('session.new') end";
      mode = "n";
      options.desc = "New session";
    }
  ];
}
