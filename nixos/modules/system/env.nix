{ config, ... }:
{
  environment.variables = {
    EDITOR = config.custom.defaultApplications.editor;
  };
}
