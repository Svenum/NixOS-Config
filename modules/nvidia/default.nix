{ config, pkgs, lib, nvidia, ... }:

let
  # Check if is hybrid
  isHybrid = if builtins.hasAttr "hybridGraphics" nvidia then nvidia.hybridGraphics else false;

  # Create nvidia pciAddresses
  pciAddress1 = if isHybrid then (builtins.toString ("0000:0" + ( builtins.replaceStrings [ "PCI:" "0:" ] [ "" "00." ] nvidia.nvidiaBusId))) else "";
  pciAddress2 = if isHybrid then (builtins.toString (builtins.replaceStrings [ ".0" ] [ ".1" ] pciAddress1)) else "";
  pciAddress1Short = if isHybrid then (builtins.toString (builtins.replaceStrings [ "0000:" ] [ "" ] pciAddress1)) else "";

  script = ''
    #!/usr/bin/env bash

    if [[ $(id -u) != 0 ]]; then
      sudo $0
      exit 0
    fi
    lspci | grep ${pciAddress1Short} > /dev/zero
    status=$?

    if [[ $status == 0 ]]; then
      echo "Unbinding GPU..."
      modprobe -r nvidia-drm
      modprobe -r nvidia
      if [[ $? != 0 ]]; then
        echo "Unable to unbind GPU becouse it is in use!"
        exit 1
      fi
      echo 1 > /sys/bus/pci/devices/${pciAddress1}/remove 
      echo 1 > /sys/bus/pci/devices/${pciAddress2}/remove 
      sleep 1
      echo "Done!"
    else
      echo "Binding GPU..."
      echo 1 > /sys/bus/pci/rescan
      sleep 1
      echo "Done!"
    fi

    exit 0
  '';

  # Create toggle script
  toggle_gpu = lib.mkIf isHybrid (
    pkgs.writeShellScriptBin "toggle_gpu" script
  );
in
{
  # Load kernel Modules
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.extraModprobeConfig = lib.mkIf isHybrid ''
    blacklist vga16fb
    blacklist nouveau
    blacklist rivafb
    blacklist nvidiafb
    blacklist rivatv
  '';

  # Configure nvidia driver
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
      ];
    };
    nvidia = {
      nvidiaSettings = true;
      open = false;
      modesetting.enable = true;
      powerManagement = lib.mkIf isHybrid {
        enable = true;
        finegrained = true;
      };
      prime = lib.mkIf isHybrid {
        offload = {
          enableOffloadCmd = true;
        };
        reverseSync.enable = true;
        amdgpuBusId = nvidia.amdgpuBusId;
        nvidiaBusId = nvidia.nvidiaBusId;
      };
    };
  };

  # Install ToggleScript
  environment.systemPackages = with pkgs; if isHybrid then [ toggle_gpu ] else [] ++ [ nvtop ];

  # Gamemode
  programs.gamemode.enable = true;

  # Create specialisation without gpu
  specialisation = lib.mkIf isHybrid {
    on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      services.xserver.videoDrivers = lib.mkForce [ "amdgpu" ];
      boot.postBootCommands = ''
        echo 0 > /sys/bus/pci/devices/${pciAddress1}/enable
        echo 0 > /sys/bus/pci/devices/${pciAddress1}/enable
        echo 0 > /sys/bus/pci/devices/${pciAddress2}/enable
        echo 1 > /sys/bus/pci/devices/${pciAddress1}/remove 
        echo 1 > /sys/bus/pci/devices/${pciAddress2}/remove 
      '';
    };
  };
}
