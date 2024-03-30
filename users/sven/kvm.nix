{ lib, systemConfig, nixvirt, ... }:

let
  nvramDefaultPath = /home/sven/.local/share/libvirt/qemu;
in
{
  # Enable virtualisation
  virtualisation.libvirt.swtpm.enable = true;
  virtualisation.libvirt.enable = true;
  virtualisation.libvirt.connections."qemu:///session" = {
    # Add networks
    networks = [
      {
        definition = nixvirt.lib.network.writeXML (nixvirt.lib.network.templates.bridge
          {
            uuid = "309c435b-5b7e-4dd7-921c-fd24e4e30951";
            subnet_byte = 71;
          });
        active = true;
      }
    ]; 
    # Add pools
    pools = [
      {
        definition = nixvirt.lib.pool.writeXML {
          name = "isos";
          uuid = "5217ddb8-29c2-4a4d-b976-73b9dde59e43";
          type = "dir";
          target = {
            path = "/home/sven/.local/share/libvirt/isos";
          };
        };
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
      }
    ];
    # Add windows Domain
    #domains = [
    #  (
    #    lib.mkIf (systemConfig.networking.hostName == "Shi")
    #    {
    #      definition = nixvirt.lib.domain.writeXML (nixvirt.lib.domain.templates.windows
    #        {
    #          name = "win10";
    #          uuid = "a9329510-9185-4849-a4ed-0b52aa2f4d47";
    #          memory = { count = 24; unit = "GiB"; };
    #          storage_vol = { pool = "default"; volume = "win10.qcow2"; };
    #          nvram_path = nvramDefaultPath + /win10.nvram;
    #          virtio_net = true;
    #          virtio_drive = true;
    #          install_virtio = true;
    #        }
    #      );
    #    }






    #    #{
    #    #  definition = nixvirt.lib.pool.writeXML {
    #    #    vcpu.count = 12;
    #    #    os = {
    #    #      type = "pc-q35-8.2"
    #    #      arch = "x86_64";
    #    #      machine = "qt5"
    #    #      boot = [ { dev = "hd"; } ];
    #    #      loader = {
    #    #        readonly = true;
    #    #        type = "pflash";
    #    #        path = "${nixvirt.lib.nixpkgs-ovmf.OVMFFull.fd}/FV/OVMF_CODE.ms.fd";
    #    #      };
    #    #      nvram = {
    #    #        
    #    #      };
    #    #    };
    #    #  };
    #    #}
    #  )
    #];
  };
}
