{ custom, ... }:
{
  home.sessionVariables = {
    EDITOR = custom.defaultApplications.editor;
  };
}
