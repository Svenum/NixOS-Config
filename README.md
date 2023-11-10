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
│       ├── catppuccin-latte.jpg
│       └── catppuccin-mocha.jpg
├── custom-nixpkgs
│   └── tetris
│       ├── default.nix
│       └── derivation.nix
├── flake.lock
├── flake.nix
├── flake.nix.bak
├── homes
│   └── sven
│       ├── default.nix
│       └── packages.nix
├── hosts
│   ├── default
│   │   ├── default.nix
│   │   ├── desktop.nix
│   │   ├── language.nix
│   │   ├── network.nix
│   │   ├── packages.nix
│   │   ├── printer.nix
│   │   ├── shell.nix
│   │   ├── skel.nix
│   │   └── tmux.nix
│   └── srv-nixostest
│       ├── default.nix
│       ├── desktop.nix
│       ├── fs.nix
│       ├── kernel.nix
│       └── network.nix
├── modules
│   ├── boot
│   │   └── default.nix
│   ├── desktop
│   │   ├── default.nix
│   │   └── plasma.nix
│   ├── flatpak
│   │   └── default.nix
│   ├── locale
│   │   ├── de_DE.nix
│   │   ├── default.nix
│   │   ├── en_DE.nix
│   │   └── en_US.nix
│   ├── nvim
│   │   └── default.nix
│   ├── rdp
│   │   └── default.nix
│   ├── tmux
│   └── user
│       └── default.nix
├── README.md
├── scripts
│   ├── home-backup.sh
│   ├── prepare_discord.sh
│   ├── prepare_spotify.sh
│   └── san_toggle_gpu.sh
└── skel
    ├── template-dark
    └── template-light
```

## Variables

| Variable | Description | Default | Valid Values | Type |
| -------- | ----------- | ------- | ------------ | ---- |
| themeAccent | Accent of the Catppuccin theme | none | [ "mocha", "teal", "frappe", "macchiato" ] | string |
| themeFlavour | Flavour of the Catppuccin Theme | none | [ "rosewater", "flamingo", "pink", "mauve", "red", "maroon", "peach", "yellow", "green", "teal", "sky", "sapphire", "blue", "lavender" ] | string |
| themeMode | Mode of the Theme | none | [ "dark", "light" ] | string |
| userAttrs.\<name\>.isGuiUser | Enable gui settings for user | false | [ false true ] | boolean |
| userAttrs.\<name\>.isSudoUser | Enable sudo for this user | false | [ false true ] | boolean |
| userAttrs.\<name\>.git.userName | Git userName | none | | string |
| userAttrs.\<name\>.git.userEmail | Git userEmail | none | | string |
| userAttrs.\<name\>.shell | Shell for user | none | | string |
| locale | locale to use | none | [ "de_DE" "en_DE" "en_US" ] | string |
| tz | timezone of the system | none | | string |
| kbLayout | Keyboard layout | none | | string |
| de | Desctop Environment to use | none | [ "plasma" ] | string |
| shell | System default shell | none | [ "zsh" ] | string |
| printerAttrs.*.name | Cups name for printer| none | | string |
| printerAttrs.*.deviceUri | Uri of printer | none |  | string |
| printerAttrs.*.model | Model of printer | none |  | string |
| printerAttrs.*.pageSize | Default Size of Page | "A4" |  | string |
| printerAttrs.*.description | Printer Name in GUI | none |  | string |
| printerAttrs.*.isDefault | Set Printer as default | false | [ true false ] | boolean |


