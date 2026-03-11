{
  lib,
  mkAction,
  pluginCfg,
  ...
}: let
  prefix = "<leader>d";
  action = func: mkAction "dap" func {};
in {
  programs.nixvim = {
    keymaps =
      lib.optionals pluginCfg.dap.enable
      (map (m: m // {mode = "n";}) [
        # --- Execution ---
        {
          key = "<F5>";
          action = action "continue";
          options.desc = "Debugger: Start";
        }
        {
          key = prefix + "c";
          action = action "continue";
          options.desc = "Start/Continue (F5)";
        }
        {
          key = "<F17>";
          action = action "terminate";
          options.desc = "Debugger: Stop (S-F5)";
        }
        {
          key = prefix + "Q";
          action = action "terminate";
          options.desc = "Terminate Session (S-F5)";
        }
        {
          key = prefix + "s";
          action = action "run_to_cursor";
          options.desc = "Run To Cursor";
        }

        # --- Stepping ---
        {
          key = "<F10>";
          action = action "step_over";
          options.desc = "Debugger: Step Over";
        }
        {
          key = prefix + "o";
          action = action "step_over";
          options.desc = "Step Over (F10)";
        }
        {
          key = "<F11>";
          action = action "step_into";
          options.desc = "Debugger: Step Into";
        }
        {
          key = prefix + "i";
          action = action "step_into";
          options.desc = "Step Into (F11)";
        }
        {
          key = "<F23>";
          action = action "step_out";
          options.desc = "Debugger: Step Out (S-F11)";
        }
        {
          key = prefix + "O";
          action = action "step_out";
          options.desc = "Step Out (S-F11)";
        }

        # --- Breakpoints ---
        {
          key = "<F9>";
          action = action "toggle_breakpoint";
          options.desc = "Debugger: Toggle Breakpoint";
        }
        {
          key = prefix + "b";
          action = action "toggle_breakpoint";
          options.desc = "Toggle Breakpoint (F9)";
        }
        {
          key = "<F21>";
          action.__raw =
            # lua
            ''
              function()
                vim.ui.input({ prompt = "Condition: " }, function(condition)
                  if condition then require("dap").set_breakpoint(condition) end
                end)
              end
            '';
          options.desc = "Debugger: Conditional Breakpoint (S-F9)";
        }

        # --- UI & Extras ---
        {
          key = prefix + "R";
          action = action "repl.toggle";
          options.desc = "Toggle REPL";
        }
      ]);

    # Keep your which-key grouping intact
    plugin.which-key.settings.spec = lib.optionals pluginCfg.dap.enable [
      {
        __unkeyed-1 = prefix;
        mode = ["n" "v"];
        group = "Debugger";
      }
    ];
  };
}
