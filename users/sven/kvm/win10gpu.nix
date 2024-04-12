{ disk_path, nvram_path, pkgs, uuid }:

let
  vmConf = import ./win10.nix {inherit disk_path; inherit nvram_path; inherit pkgs; inherit uuid; };
in
vmConf // {
  name = "Windows GPU Nix";
  uuid = uuid;
  description = "A Windows 10 vm define in nix with gpu passthrough";
  devices = vmConf.devices // {
    # GPU passthrough
    shmem = [
      {
        name = "looking-glass-sven";
        model.type = "ivshmem-plain";
        size = { unit = "M"; count = 128; };
      }
    ];
    
    video = {
      model = {
        type = "none";
      };
    };

    hostdev = vmConf.devices.hostdev ++ [
      {
        mode = "subsystem";
        type = "pci";
        managed = true;
        source.address = {
          domain = 0;
          bus = 3;
          slot = 0;
          function = 0;
        };
      }
      {
        mode = "subsystem";
        type = "pci";
        managed = true;
        source.address = {
          domain = 0;
          bus = 3;
          slot = 0;
          function = 1;
        };
      }
    ];
  };
}
