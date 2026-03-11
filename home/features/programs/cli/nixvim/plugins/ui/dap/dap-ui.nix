{config, ...}: let
  cfg = config.programs.nixvim.plugins.dap;
in {
  programs.nixvim = {
    plugins = {
      dap-ui = {inherit (cfg) enable;};
      dap-virtual-text = {inherit (cfg) enable;};
    };
    autoCmd = [
      # INFO: load/open/close the debugger's ui along with the debbuger itself.
      {
        event = ["User"];
        pattern = ["LazyLoad"];
        callback.__raw =
          # lua
          ''
            function(event)
              if event.data == "nvim-dap" then
                local dap, dapui = require("dap"), require("dapui")

                -- Open UI when a debug session initializes or hits a breakpoint
                dap.listeners.after.event_initialized["dapui_config"] = function()
                  dapui.open()
                end

                -- Automatically close UI when the session ends
                dap.listeners.before.event_terminated["dapui_config"] = function()
                  dapui.close()
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                  dapui.close()
                end
              end
            end
          '';
      }
    ];
  };
}
