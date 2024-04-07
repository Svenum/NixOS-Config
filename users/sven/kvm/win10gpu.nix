{ disk_path, nvram_path, pkgs }:

import ./win10.nix {inherit disk_path; inherit nvram_path; inherit pkgs;} // {
  devices = {
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
