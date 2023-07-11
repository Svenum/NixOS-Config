# NixOS-Config

## Directories

```
/etc/nixos
├── configs
│   └── init.vim
├── custom-nixpkgs
│   └── catppuccin-tmux
│       ├── default.nix
│       └── derivation.nix
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
│   ├── template-dark
│   └── template-light
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
    │   ├── skel.nix
    │   ├── tmux.nix
    │   └── user.nix
    ├── Ni
    │   ├── default.nix
    │   ├── network.nix
    │   ├── nvim.nix
    │   ├── packages.nix
    │   ├── skel.nix
    │   └── tmux.nix
    ├── San
    │   ├── default.nix
    │   ├── desktop.nix
    │   ├── fs.nix
    │   ├── hardware.nix
    │   ├── kernel.nix
    │   ├── network.nix
    │   ├── nvidia.nix
    │   ├── nvim.nix
    │   ├── packages.nix
    │   ├── skel.nix
    │   ├── tlp.nix
    │   ├── tmux.nix
    │   └── virtualisation.nix
    └── srv-nixostest
        ├── default.nix
        ├── fs.nix
        ├── kernel.nix
        ├── network.nix
        ├── nvim.nix
        ├── skel.nix
        └── tmux.nix
```
