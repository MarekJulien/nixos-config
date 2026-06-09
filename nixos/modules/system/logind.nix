{ ... }:
{
  services.logind = {
    enable = true;
    settings.Login = {
      HandleLidSwitch = "ignore";
      HandlePowerKey="ignore";
      KillUserProcesses = false;
    };
  };
}

