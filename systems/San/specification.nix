{ lib, ...}:

{
  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "Nvidia_Always_On" ];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce false;
        powerManagement.enable = lib.mkForce false;
      };
    };
  };
}
