{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop-amd
      nvtop-nvidia
    ];
  };
}
