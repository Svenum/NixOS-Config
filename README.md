# NixOS-Config

## Directories

```
/etc/nixos/
├── flake.lock
├── flake.nix
├── home.nix
├── homes
│   ├── susven
│   │   ├── default.nix
│   │   └── flatpak.nix
│   └── sven
│       ├── default.nix
│       ├── flatpak.nix
│       └── packages.nix
├── modules
│   └── flatpak.nix
├── README.md
└── systems
    ├── all
    │   ├── bootloader.nix
    │   ├── default.nix
    │   ├── desktop.nix
    │   ├── language.nix
    │   ├── nvim.nix
    │   ├── packages.nix
    │   ├── plymouth.nix
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
    │   └── virtualisation.nix
    └── srv-nixostest
        ├── default.nix
        ├── hardware-configuration.nix
        └── network.nix
```


## ToDo

### Sven
1. KDE Settings -> Applications -> Flatpak Permission Settings -> Steam -> Advanced Permissions -> Enable Direct Graphic Rendering
2. add "nvidia-offload" to var.valvesoftware.Steam.desktop

