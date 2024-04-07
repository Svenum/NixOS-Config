{ disk_path, nvram_path, pkgs }:

let
  vmConf = import ./win10.nix {inherit disk_path; inherit nvram_path; inherit pkgs;};
in
vmConf // {
  name = "Windows GPU Nix";
  uuid = "3af8cded-1545-4ff2-87d6-d647119aa0e3";
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

    hostdev = [
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
