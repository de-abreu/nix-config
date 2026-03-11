# INFO: Nvim settings are here defined. To have more info on what each of these
# options do, search for them using the `:h` or `:help` prefixes
{
  programs.nixvim = {
    # feature that enhances the way Neovim loads and executes Lua modules,
    # offering improved performance and flexibility.
    luaLoader.enable = true;

    clipboard.providers.wl-copy.enable = true;

    globals = {
      # Disable unused providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };
    opts = import ./opts.nix;
  };
}
