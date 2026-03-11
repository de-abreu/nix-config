{
  config,
  lib,
  ...
}: {
  programs.nixvim.plugins.treesitter = let
    allGrammars = config.plugins.treesitter.package.passthru.allGrammars;
  in {
    enable = true;
    # folding.enable = true;

    grammarPackages = let
      # Large grammars that are not used
      excludedGrammars = [
        "agda-grammar"
        "cuda-grammar"
        "d-grammar"
        "fortran-grammar"
        "gnuplot-grammar"
        "haskell-grammar"
        "hlsl-grammar"
        "julia-grammar"
        "koto-grammar"
        "lean-grammar"
        "nim-grammar"
        "scala-grammar"
        "slang-grammar"
        "systemverilog-grammar"
        "tlaplus-grammar"
        "verilog-grammar"
      ];
    in
      lib.filter (
        g: !(lib.elem g.pname excludedGrammars)
      )
      allGrammars;

    settings = {
      highlight = {
        additional_vim_regex_highlighting = true;
        enable = true;
        disable =
          # lua
          ''
            function(lang, bufnr)
              return vim.api.nvim_buf_line_count(bufnr) > 10000
            end
          '';
      };

      incremental_selection.enable = true;
      indent.enable = true;
    };
    nixvimInjections = true;
  };
}
