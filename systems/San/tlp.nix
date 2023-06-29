{ ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "AC";
      SOUND_POWER_SAVE_ON_BAT = 10;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
      DISK_SPINDOWN_TIMEOUT_ON_BAT = "1 120";
      SATA_LINKPWR_BAT = "med_power_with_dipm min_power";
      AHCI_RUNTIME_PME_ON_BAT = "auto";
      AHCI_RUNTIME_PM_TIMEOUT = 15;
      RADEON_DPM_ON_AC = "performance";
      RADEON_DPM_ON_DC = "battery";
      WOL_DISABLE = "Y";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      SCHED_POWERSAVE_ON_AC = 0;
      SCHED_POWERSAVE_ON_BAT = 1;
      RESTORE_DEVICE_STATE_ON_STARTUP = 0;
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wifi wwan";
      DEVICES_TO_ENABLE_ON_AC = "wifi wwan";
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave";
      USB_AUTOSUSPEND = 1;
    };
  };
  services.power-profiles-daemon.enable = false;
}
