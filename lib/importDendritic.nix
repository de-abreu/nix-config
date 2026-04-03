{lib}:
with lib; let
  inherit (builtins) readDir filterAttrs attrNames hasSuffix isDerivation;
in {
  importDendritic = {
    dir,
    inherit ? [],
    exclude ? [],
  }:
    readDir dir
    |> filterAttrs (
      name: type:
      let
        isNixFile = hasSuffix ".nix" name && name != "default.nix";
        isDirectory = type == "directory";
        isNotExcluded = !(elem name exclude);
      in
        (isNixFile || isDirectory) && isNotExcluded
    )
    |> attrNames
    |> map (name: dir + "/${name}");
}