{
  importAll,
  snacksAction,
  ...
}: {
  imports = importAll {dir = ./.;};

  _module.args.pickerAction = func: snacksAction "picker.${func}" {};
}
