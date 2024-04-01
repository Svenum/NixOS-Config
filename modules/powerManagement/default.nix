{ auto-cpufreq, ... }:

{
  imports = [
    auto-cpufreq.nixosModules.default
  ];

  # Enable NixOS powermanagement + powertop
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # Enable powerpfiles
  services.power-profiles-daemon.enable = true;

  # Enable auto-cpufreq
  #programs.auto-cpufreq = {
  #  enable = true;
  #  settings = {
  #    battery = {
  #      energy_performance_preference = "power";
  #      governor = "powersave";
  #      turbo = "never";
  #    };
  #    charger = {
  #      energy_performance_preference = "balance_performance";
  #      governor = "performance";
  #      turbo = "auto";
  #    };
  #  };
  #};
  services.tlp.enable = true;
}
