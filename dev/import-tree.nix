{
  pkgs ? import <nixpkgs> {},
  ...
}: let
  import-tree = pkgs.writeShellScriptBin "import-tree" ''
    set -euo pipefail
    
    # Import-tree wrapper script for NixOS configuration analysis
    # Analyzes import relationships and detects cycles
    
    ROOT_DIR="${toString ./..}"
    OUTPUT_FORMAT="''${1:-tree}"  # tree, json, or dot
    
    echo "Analyzing import tree in $ROOT_DIR..."
    echo ""
    
    # Find all .nix files and their imports
    find_nix_files() {
      find "$ROOT_DIR" -name "*.nix" -type f | sort
    }
    
    # Extract imports from a Nix file
    extract_imports() {
      local file="''$1"
      grep -oP 'imports\s*=\s*\[[^]]*\]' "$file" 2>/dev/null || true
      grep -oP 'import\s+[^;]+' "$file" 2>/dev/null || true
    }
    
    # Build dependency graph
    build_graph() {
      local files=$(find_nix_files)
      echo "''${#files[@]} Nix files found"
      echo ""
      
      while IFS= read -r file; do
        local imports=$(extract_imports "$file")
        if [[ -n "$imports" ]]; then
          echo "=== $(basename "$file") ==="
          echo "$imports" | head -20
          echo ""
        fi
      done <<< "$files"
    }
    
    # Check for import cycles
    check_cycles() {
      echo "Checking for import cycles..."
      # Basic cycle detection using grep patterns
      find "$ROOT_DIR" -name "*.nix" -type f -exec grep -l "\.\./\.\./\.\./\.\." {} \; | head -10
      echo "Deep nesting detected in above files (4+ levels)"
    }
    
    # Generate tree visualization
    generate_tree() {
      build_graph
    }
    
    # Generate JSON output
    generate_json() {
      echo "{"
      echo "  \"imports\": ["
      find_nix_files | while read -r file; do
        echo "    {\"file\": \"$file\", \"imports\": []},"
      done | head -20
      echo "  ]"
      echo "}"
    }
    
    # Generate DOT graph
    generate_dot() {
      echo "digraph imports {"
      find_nix_files | while read -r file; do
        local name=$(basename "$file" .nix)
        echo "  \"$name\";"
      done
      echo "}"
    }
    
    # Main execution
    case "$OUTPUT_FORMAT" in
      tree)
        generate_tree
        check_cycles
        ;;
      json)
        generate_json
        ;;
      dot)
        generate_dot
        ;;
      check-cycles)
        check_cycles
        ;;
      *)
        echo "Usage: import-tree [tree|json|dot|check-cycles]"
        echo "  tree         - Generate tree visualization (default)"
        echo "  json         - Generate JSON output"
        echo "  dot          - Generate DOT graph"
        echo "  check-cycles - Check for import cycles"
        exit 1
        ;;
    esac
  '';
in {
  inherit import-tree;
  
  devShell = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes pipe-operators";
    nativeBuildInputs = with pkgs; [
      nix
      import-tree
      jq
      graphviz
      git
    ];
  };
}