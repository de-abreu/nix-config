{
  config,
  lib,
  ...
}:
targetDesc: icon:
let
  # --- 1. Fetch Keymap Data by Description ---
  km = lib.findFirst (k: (k.options.desc or "") == targetDesc) null config.programs.nixvim.keymaps;

  # Extract basic values
  key = if km != null then km.key else "";
  desc = if km != null then km.options.desc else targetDesc;

  # --- 2. Safely Parse the Action Type ---
  action =
    if km == null then
      "nil"
    else if builtins.isString km.action then
      ''"${km.action}"'' # Wrap Vim commands in quotes
    else if km.action ? __raw then
      km.action.__raw # Leave Lua functions unquoted
    else
      "nil";

  # --- 3. Infer Leader & Format Display Key ---
  leader = config.programs.nixvim.globals.mapleader or " ";
  displayLeader = if leader == " " then "SPC" else leader;

  isLeader = lib.hasPrefix "<leader>" key || lib.hasPrefix "<Leader>" key;
  rest = if isLeader then lib.replaceStrings [ "<leader>" "<Leader>" ] [ "" "" ] key else key;
  restNormalized = lib.replaceStrings [ "<space>" "<Space>" ] [ "SPC" "SPC" ] rest;

  chars = if restNormalized == "SPC" then [ "SPC" ] else lib.stringToCharacters restNormalized;
  spacedRest = lib.concatStringsSep " " chars;

  displayKey =
    if key == "" then
      "???"
    else if isLeader then
      "${displayLeader} ${spacedRest}"
    else
      spacedRest;
in
# --- 4. Skip if not found ---
if km == null then "" else ''dashboard.button("${displayKey}", "${icon}  ${desc}", ${action}),''
