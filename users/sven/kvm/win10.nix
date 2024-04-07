{ disk_path, nvram_path, pkgs }:

{
  type = "kvm";
  # VM Infos
  name = "Windows Nix";
  uuid = "c08333dc-33f9-4117-969a-ac46e19ba81f";
  description = "A Windows 10 vm define in nix";
  
  # CPU and RAM
  vcpu = { count = 12; placement = "static"; };
  memory = { count = 20; unit = "GiB"; };
  cpu = {
    mode = "host-passthrough";
    check = "none";
    migratable = true;
    topology = {
      sockets = 1;
      dies = 1;
      cores = 6;
      threads = 2;
    };
  };

  # OS
  os = {
    type = "hvm";
    arch = "x86_64";
    machine = "pc-q35-8.2";
    boot = { dev = "hd"; };
    loader = {
      readonly = true;
      type = "pflash";
      path = "${pkgs.OVMFFull.fd}/FV/OVMF_CODE.ms.fd";
    };
    nvram = {
      template = "${pkgs.OVMFFull.fd}/FV/OVMF_VARS.ms.fd";
      path = "${nvram_path}/win10gpu.nvram";
    };
  };

  features = {
    acpi = {};
    apic = {};
    hyperv = {
      mode = "custom";
      relaxed = { state = true; };
      vapic = { state = true; };
      spinlocks = { state = true; retries = 8191; };
      vendor_id = { state = true; value = "1234567890ab"; };
    };
    kvm.hidden = { state = true; };
    vmport.state = false;
  };
  
  clock = {
    offset = "localtime";
    timer = [
      { name = "rtc"; tickpolicy = "catchup"; }
      { name = "pit"; tickpolicy = "delay"; }
      { name = "hpet"; present = false; }
      { name = "hypervclock"; present = true; }
    ];
  };

  ## PowerManagement

  ## MISSING
  ## <on_poweroff>destroy</on_poweroff>
  ## <on_reboot>restart</on_reboot>
  ## <on_crash>destroy</on_crash>

  pm = {
    suspend-to-mem = { enabled = false; };
    suspend-to-disk = { enabled = false; };
  };

  # Devices
  devices = {
    emulator = "${pkgs.qemu}/bin/qemu-system-x86_64";

    # Disks
    disk = [
      {
        type = "file";
        device = "disk";
        driver = {
          name = "qemu";
          type = "qcow2";
          discard = "unmap";
        };
        source.file = "${disk_path}/win10gpu.qcow2";
        target = { dev = "sda"; bus = "sata"; };
      }
    ];

    # Network
    interface = {
      type = "network";
      mac.address = "52:54:00:04:63:98";
      source.network = "default";
      model.type = "e1000e";
    };

    # Input
    input = [
      { type = "keyboard"; bus = "virtio"; }
      { type = "mouse"; bus = "virtio"; }
    ];

    # Video + Audio
    graphics = {
      type = "spice";
      autoport = true;
      listen = { type = "address"; };
      image = { compression = false; };
    };

    video = {
      model = {
        type = "vga";
        vram = 65536;
        heads  = 1;
        primary = true;
      };
    };

    sound = { model = "ich9"; };
    audio = { id = 1; type = "spice"; };

    # Interfaces 
    controller = [
      { type = "usb"; index = 0; model = "qemu-xhci"; ports = 15; }
      { type = "pci"; index = 0; model = "pcie-root"; }
      { type = "virtio-serial"; index = 0; }
    ];

    serial = [
      {
        type = "pty";
        target = { type = "isa-serial"; port = 0; model.name = "isa-serial"; };
      }
    ];

    console = [
      {
        type = "pty";
        target = { type = "serial"; port = 0; };
      }
    ];

    channel = [
      {
        type = "spicevmc";
        target = { type = "virtio"; name = "com.redhat.spice.0"; };
      }
    ];

    # Other
    watchdog = { model = "itco"; action = "reset"; };
    memballoon.model = "none";
  };

  qemu-commandline = {
    arg = [
      { value = "-cpu"; }
      { value = "host,kvm=off,hv_vendor_id=null"; }
      { value = "-machine"; }
      { value = "q35"; }
    ]; 
  };
}
