# INFO: Python linting and formatting with Ruff
# Ruff handles both linting and formatting (replacing flake8, black, isort, etc.)
{
  programs.nixvim = {
    lsp.servers.ruff = {
      enable = true;
      # Disable hoverProvider to avoid conflicts with basedpyright
      # Ruff is for linting/formatting, not type information
      config.onAttach.function =
        # lua
        ''
          function(client, bufnr)
            client.server_capabilities.hoverProvider = false
          end
        '';
    };

    # Configure conform-nvim for formatting with Ruff
    plugins.conform-nvim.settings = {
      formatters_by_ft = {
        python = [
          "ruff_fix" # Fix auto-fixable lint violations
          "ruff_organize_imports" # Organize imports
          "ruff_format" # Format code
        ];
      };
    };
  };
}
