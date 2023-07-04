# NixOS-Config

## Directories

```
/etc/nixos
├── flake.lock
├── flake.nix
├── homes
│   ├── susven
│   │   ├── default.nix
│   │   └── flatpak.nix
│   └── sven
│       ├── default.nix
│       ├── flatpak.nix
│       └── packages.nix
├── README.md
├── skel
└── systems
    ├── all
    │   ├── bootloader.nix
    │   ├── default.nix
    │   ├── desktop.nix
    │   ├── language.nix
    │   ├── nvim.nix
    │   ├── packages.nix
    │   ├── plymouth.nix
    │   ├── shell.nix
    │   └── user.nix
    ├── Ni
    │   ├── network.nix
    │   └── packages.nix
    ├── San
    │   ├── default.nix
    │   ├── fs.nix
    │   ├── hardware.nix
    │   ├── kernel.nix
    │   ├── network.nix
    │   ├── nvidia.nix
    │   ├── packages.nix
    │   ├── tlp.nix
    │   └── virtualisation.nix
    └── srv-nixostest
        ├── default.nix
        ├── hardware-configuration.nix
        └── network.nix
```


## ToDo

### Sven
1. add "nvidia-offload" to var.valvesoftware.Steam.desktop
