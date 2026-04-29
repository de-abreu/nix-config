# INFO: Java language support using nvim-java
# nvim-java automatically manages: jdtls, lombok, java-test, java-debug-adapter, spring-boot-tools
{
  programs.nixvim = {

    # Suppresses lspconfig deprecation warnings from nvim-java: its stable version still uses `require('lspconfig')`
    extraConfigLuaPre = ''
      local orig_deprecate = vim.deprecate
      vim.deprecate = function(name, banner, ...)
        if (name and name:match("lspconfig")) or (banner and banner:match("lspconfig")) then
          return
        end
        return orig_deprecate(name, banner, ...)
      end
    '';

    plugins.java = {
      enable = true;
      lazyLoad.settings.event = [ "DeferredUIEnter" ];
      # NOTE: JDK should be provided at the project's dev flake
      settings.jdk.auto_install = false;
    };
  };

  # nvim-java requires mason to manage its installation of java dependencies. This configuration sets up the proper registries
  extra.lz-n.plugins = [
    {
      __unkeyed-1 = "mason.nvim";
      event = [ "DeferredUIEnter" ];
      after.__raw = ''
        require('mason').setup({
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        })
      '';
    }
  ];
}
