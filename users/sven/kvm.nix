{ nixVirt, systemConfig, ... }:

{
  # import home-manager module
  imports = [ nixVirt.homeModules.default ];

  virtualisation.libvirt.connections."qemu:///session" = {
    # Add isos pool
    pools = [
      {
        definition = nixvirt.lib.pool.writeXML {
          name = "isos";
          path = "/home/sven/.local/share/libvirt/isos";
        };
      }
    ];
    # Add windows Domain
    domains = [
      (
        lib.mkIf (systemConfig.networking.hostName == "Shi")
        {
          definition = nixvirt.lib.domain.writeXML (nixvirt.lib.domain.templates.windows
            {
              name = "win10";
              memory = { count = 24; unit = "GiB" };
              storage_vol = { pool = "default"; volume = "win10.qcow2" };
              virtio_net = true;
              virtio_drive = true;
              install_virtio = true;
            }
          );
        }






        #{
        #  definition = nixvirt.lib.pool.writeXML {
        #    vcpu.count = 12;
        #    os = {
        #      type = "pc-q35-8.2"
        #      arch = "x86_64";
        #      machine = "qt5"
        #      boot = [ { dev = "hd"; } ];
        #      loader = {
        #        readonly = true;
        #        type = "pflash";
        #        path = "${nixVirt.nixpkgs-ovmf.OVMFFull.fd}/FV/OVMF_CODE.ms.fd";
        #      };
        #      nvram = {
        #        
        #      };
        #    };
        #  };
        #}
      )
    ]
  };
}
