# INFO: An annotation toolkit
{
  programs.nixvim.plugins.neogen = {
    enable = true;
    settings.languages = {
      javascript.template.annotation_convention = "jsdoc";
      javascriptreact.template.annotation_convention = "jsdoc";
      typescript.template.annotation_convention = "tsdoc";
      typescriptreact.template.annotation_convention = "tsdoc";
      lua.template.annotation_convention = "ldoc";
      ruby.template.annotation_convention = "yard";
    };
  };
}
