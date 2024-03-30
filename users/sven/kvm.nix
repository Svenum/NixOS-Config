{ nixVirt, systemConfig, ... }:

{
  # import home-manager module
  imports = [ nixVirt.homeModules.default ];

  virtualisation.libvirt.connections."qemu:///session" = {
    # Add isos pool
    pools = [
      {
        definition = ./virsh/isos.xml;
      }
    ];
    # Add windows Domain
    #domains = [
    #  (
    #    lib.mkIf (systemConfig.networking.hostName == "Shi")
    #    {
    #      definition = ./virsh/win10.xml;
    #    }
    #  )
    #]
  };
}
