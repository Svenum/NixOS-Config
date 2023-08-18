{...}:

{
  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "Nvidia Always on" ];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce false;
        powerManagement.enable = lib.mkForce false;
      };
    };
  };
}
