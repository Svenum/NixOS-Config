{ nvram_path, pkgs, uuid }:

let
  vmConf = import ./win10.nix { inherit nvram_path; inherit pkgs; inherit uuid; };
in
vmConf // {
  name = "Windows GPU Nix";
  uuid = uuid;
  description = "A Windows 10 vm define in nix with gpu passthrough";
  devices = vmConf.devices // {
    # GPU passthrough
    #shmem = [
    #  {
    #    name = "looking-glass-sven";
    #    model.type = "ivshmem-plain";
    #    size = { unit = "M"; count = 128; };
    #  }
    #];
    
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

  qemu-commandline = {
    arg = vmConf.qemu-commandline.arg ++ [
      { value = "-device"; }
      { value = "{\"driver\":\"ivshmem-plain\",\"id\":\"shmem0\",\"memdev\":\"looking-glass\"}"; }
      { value = "-object"; }
      { value = "{\"qom-type\":\"memory-backend-file\",\"id\":\"looking-glass\",\"mem-path\":\"/dev/kvmfr0\",\"size\":134217728,\"share\":true}"; }
    ];
  };
}