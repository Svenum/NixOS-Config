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
              name = "win10.qcow2";
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
      {
        definition = nixvirt.lib.pool.writeXML {
          name = "qemu";
          type = "dir";
          uuid = "be62978e-1d96-466f-bfaf-acc01c9fae76";
          target = {
            path = "/home/sven/.local/share/libvirt/qemu";
          };
        };
        active = true;
      }
    ];

    # Add windows Domain
    domains = lib.mkIf (systemConfig.networking.hostName == "Shi") [
      {
        # Does not work https://github.com/AshleyYakeley/NixVirt/issues/17
        definition = nixvirt.lib.domain.writeXML (nixvirt.lib.domain.templates.windows
          {
            name = "win10";
            uuid = "a9329510-9185-4849-a4ed-0b52aa2f4d47";
            memory = { count = 24; unit = "GiB"; };
            storage_vol = { pool = "default"; volume = "win10.qcow2"; };
            nvram_path = /home/sven/.local/share/libvirt/qemu/win10.nvram;
            virtio_drive = true;
          }
        );



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
        #        path = "${nixvirt.lib.nixpkgs-ovmf.OVMFFull.fd}/FV/OVMF_CODE.ms.fd";
        #      };
        #      nvram = {
        #        
        #      };
        #    };
        #  };
        #}
      }
    ];
  };
}
