# NixOS-Config

## Directories

```
/etc/nixos
├── configs
│   ├── asound.conf
│   ├── catppuccin_frappe-zsh-syntax-highlighting.zsh
│   ├── catppuccin_latte-zsh-syntax-highlighting.zsh
│   ├── catppuccin_macchiato-zsh-syntax-highlighting.zsh
│   ├── catppuccin_mocha-zsh-syntax-highlighting.zsh
│   ├── init.vim
│   └── wallpaper
│       ├── Catppuccin-Latte.jpg
│       └── Catppuccin-Mocha.jpg
├── custom-nixpkgs
│   ├── solaar
│   │   ├── default.nix
│   │   └── derivation.nix
│   └── tetris
│       ├── default.nix
│       └── derivation.nix
├── flake.lock
├── flake.nix
├── homes
│   └── sven
│       ├── default.nix
│       ├── flatpak.nix
│       └── packages.nix
├── README.md
├── scripts
│   ├── home-backup.sh
│   ├── prepare_discord.sh
│   └── prepare_spotify.sh
├── skel
│   ├── template-dark
│   └── template-light
└── systems
    ├── all
    │   ├── bootloader.nix
    │   ├── default.nix
    │   ├── desktop.nix
    │   ├── flatpak-fix.nix
    │   ├── kernel.nix
    │   ├── language.nix
    │   ├── network.nix
    │   ├── nvim.nix
    │   ├── packages.nix
    │   ├── plymouth.nix
    │   ├── printer.nix
    │   ├── shell.nix
    │   ├── skel.nix
    │   ├── tmux.nix
    │   └── user.nix
    ├── Ni
    │   ├── default.nix
    │   ├── devices.nix
    │   ├── fs.nix
    │   ├── hardware.nix
    │   ├── kernel.nix
    │   ├── network.nix
    │   ├── nvidia.nix
    │   ├── packages.nix
    │   ├── skel.nix
    │   └── virtualisation.nix
    ├── San
    │   ├── default.nix
    │   ├── desktop.nix
    │   ├── devices.nix
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
        ├── fs.nix
        ├── kernel.nix
        └── network.nix
```

## Variables

| Variable | Description | Default | Valid Values | Type |
| -------- | ----------- | ------- | ------------ | ---- |
| themeAccent | Accent of the Catppuccin theme | none | [ "mocha", "teal", "frappe", "macchiato" ] | string |
| themeFlavour | Flavour of the Catppuccin Theme | none | [ "rosewater", "flamingo", "pink", "mauve", "red", "maroon", "peach", "yellow", "green", "teal", "sky", "sapphire", "blue", "lavender" ] | string |
| themeMode | Mode of the Theme | none | [ "dark", "light" ] | string |
| guiUsers | Users witch use the GUI | none | | list |
| sudoUsers | Users witch get sudo rights | none | | list |
