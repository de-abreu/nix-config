# INFO: Java language support using nvim-java
# nvim-java automatically manages: jdtls, lombok, java-test, java-debug-adapter, spring-boot-tools
# NOTE: JDK should be provided by the project's dev flake or system configuration
{
  programs.nixvim.plugins.java = {
    enable = true;
    lazyLoad.settings.event = [ "DeferredUIEnter" ];
    settings.jdk.auto_install = false;
  };
}
