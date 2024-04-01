{ lib, systemConfig, nixvirt, ... }:

{
  # Enable virtualisation
  virtualisation.libvirt.swtpm.enable = true;
  virtualisation.libvirt.enable = true;
  virtualisation.libvirt.connections."qemu:///session" = {
    # Add pools
    pools = [
      {
        definition = nixvirt.lib.pool.writeXML {
          name = "default";
          uuid = "a72e2000-ab5e-4c2d-a571-daf611fc77a4";
          type = "dir";
          target = {
            path = "/home/sven/.local/share/libvirt/images";
          };
        };
        volumes = [
          {
            definition = nixvirt.lib.volume.writeXML {
              name = "win10gpu.qcow2";
              capacity = { count = 250; unit = "GiB"; };
              target = {
                format = { type = "qcow2"; };
              };
            };
          }
        ];
        active = true;
      }
      {
        definition = nixvirt.lib.pool.writeXML {
          name = "isos";
          uuid = "5217ddb8-29c2-4a4d-b976-73b9dde59e43";
          type = "dir";
          target = {
            path = "/home/sven/.local/share/libvirt/isos";
          };
        };
        active = true;
      }
    ];

    # Add windows Domain
    domains = lib.mkIf (systemConfig.networking.hostName == "Shi") [
      {
        definition = ./kvm/win10gpu.xml;
      }
    ];
  };
}
