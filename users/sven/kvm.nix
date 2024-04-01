{ lib, systemConfig, nixvirt, ... }:

{
  # Enable virtualisation
  virtualisation.libvirt.swtpm.enable = true;
  virtualisation.libvirt.enable = true;
  virtualisation.libvirt.connections."qemu:///system" = {
    # Add pools
    pools = [
      {
        definition = nixvirt.lib.pool.writeXML {
          name = "default";
          uuid = "689ba4f2-da57-43e4-9723-a0551e871c8a";
          type = "dir";
          target = {
            path = "/var/lib/libvirt/images";
          };
        };
        active = true;
      }
      {
        definition = nixvirt.lib.pool.writeXML {
          name = "images";
          uuid = "464a4f52-bbf4-479e-9b2b-ed27116aab7b";
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
