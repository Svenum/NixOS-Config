# NixOS-Config

## Directories

```
/etc/nixos
├── custom-nixpkgs
│   ├── konsole-catppuccin
│   │   ├── default.nix
│   │   ├── derivation.nix
│   │   └── profile
│   │       ├── Catppuccin-Latte.profile
│   │       └── Catppuccin-Mocha.profile
│   ├── plasma-applet-betterinlineclock
│   │   ├── default.nix
│   │   └── derivation.nix
│   ├── plasma-applet-shutdownorswitch
│   │   ├── default.nix
│   │   └── derivation.nix
│   └── tetris
│       ├── default.nix
│       └── derivation.nix
├── flake.lock
├── flake.nix
├── hosts
│   ├── Ni
│   │   ├── default.nix
│   │   └── settings.nix
│   ├── PC-Carmen
│   │   ├── default.nix
│   │   └── settings.nix
│   ├── San
│   │   ├── default.nix
│   │   └── settings.nix
│   ├── srv-nixostest
│   │   ├── default.nix
│   │   └── settings.nix
│   └── Zeta
│       ├── default.nix
│       └── settings.nix
├── modules
│   ├── bluetooth
│   │   └── default.nix
│   ├── boot
│   │   └── default.nix
│   ├── cliTools
│   │   ├── default.nix
│   │   └── script
│   │       └── backup.sh
│   ├── desktop
│   │   ├── default.nix
│   │   ├── image
│   │   │   ├── catppuccin-latte.jpg
│   │   │   └── catppuccin-mocha.jpg
│   │   └── plasma.nix
│   ├── flatpak
│   │   ├── default.nix
│   │   └── script
│   │       ├── prepare_discord.sh
│   │       └── prepare_spotify.sh
│   ├── kvm
│   │   └── default.nix
│   ├── locale
│   │   ├── de_DE.nix
│   │   ├── default.nix
│   │   ├── en_DE.nix
│   │   └── en_US.nix
│   ├── network
│   │   └── default.nix
│   ├── nixos
│   │   └── default.nix
│   ├── nvidia
│   │   └── default.nix
│   ├── nvim
│   │   ├── config
│   │   │   └── init.vim
│   │   └── default.nix
│   ├── printer
│   │   └── default.nix
│   ├── rdp
│   │   └── default.nix
│   ├── shell
│   │   ├── config
│   │   │   └── zsh
│   │   │       ├── catppuccin_frappe-zsh-syntax-highlighting.zsh
│   │   │       ├── catppuccin_latte-zsh-syntax-highlighting.zsh
│   │   │       ├── catppuccin_macchiato-zsh-syntax-highlighting.zsh
│   │   │       ├── catppuccin_mocha-zsh-syntax-highlighting.zsh
│   │   │       ├── p10k.zsh
│   │   │       └── zshrc
│   │   ├── default.nix
│   │   └── zsh.nix
│   ├── tlp
│   │   └── default.nix
│   ├── tmux
│   │   └── default.nix
│   ├── user
│   │   └── default.nix
│   └── wireguard
│       └── default.nix
├── README.md
└── users
    ├── carmen
    │   └── default.nix
    ├── martinn
    │   └── default.nix
    └── sven
        └── default.nix
```

## Variables
This Variables must be layed in "/etc/hosts/COMPUTERNAME/settings.nix" and then loaded via "settings = import ./hosts/COMPUTERNAME/settings.nix" in the "specialArgs".

| Variable | Description | Default | Valid Values | Type 
| -------- | ----------- | ------- | ------------ | ---- |
| **DESKTOP** |||||
| theme.accent | Accent of the Catppuccin theme | none | [ "mocha", "teal", "frappe", "macchiato" ] | string |
| theme.flavour | Flavour of the Catppuccin Theme | none | [ "rosewater", "flamingo", "pink", "mauve", "red", "maroon", "peach", "yellow", "green", "teal", "sky", "sapphire", "blue", "lavender" ] | string |
| theme.mode | Mode of the Theme | none | [ "dark", "light" ] | string |
| de.name | Desktop Environment to use | none | [ "plasma" ] | string |
| de.waylandDefault | Enable Wayland session by default | none | [ true false ] | boolean |
| **USER** |||||
| userAttrs.\<name\>.isGuiUser | Enable gui settings for user | false | [ false true ] | boolean |
| userAttrs.\<name\>.isSudoUser | Enable sudo for this user | false | [ false true ] | boolean |
| userAttrs.\<name\>.git.userName | Git userName | none | | string |
| userAttrs.\<name\>.git.userEmail | Git userEmail | none | | string |
| userAttrs.\<name\>.shell | Shell for user | none | | string |
| userAttrs.\<name\>.authorizedKeys | SSH authorized Keys for user | none | | list |
| **LANGUAGE** |||||
| locale | locale to use | none | [ "de_DE" "en_DE" "en_US" ] | string |
| tz | timezone of the system | none | | string |
| kbLayout | Keyboard layout | none | | string |
| **SHELL** |||||
| shell | System default shell | none | [ "zsh" ] | string |
| **PRINTER/SCANNER** |||||
| printerAttrs.*.name | Cups name for printer| none | | string |
| printerAttrs.*.deviceUri | Uri of printer | none |  | string |
| printerAttrs.*.model | Model of printer | none |  | string |
| printerAttrs.*.pageSize | Default Size of Page | "A4" |  | string |
| printerAttrs.*.description | Printer Name in GUI | none |  | string |
| printerAttrs.*.isDefault | Set Printer as default | false | [ true false ] | boolean |
| enableScanner | Enable Scanner | true |[ true false ] | boolean |
| **NETWORK** |||||
| networkConfig.useDHCP | Enable DHCP | false | [ true false ] | boolean |
| networkConfig.interface | Interface to use if DHCP is disabled | none |  | string |
| networkConfig.address | IP for the interface  | none |  | string |
| networkConfig.prefixLength | Prefix for the IP Address | none |  | integer |
| networkConfig.defauiltGateway | DefaultGateway IP | none |  | string |
| networkConfig.nameservers | List of nameservers | none |  | list |
| **POWERMANAGEMENT** |||||
| tlpAttrs.deviceBlacklist | These devices are blacklisted from TLP | none |  | string |
| **GPU** |||||
| nvidia.hybridGraphics | Enable if laptop has hybrid graphics (amd and nvidia) | false | [ true false ] | boolean |
| nvidia.nvidiaBusId | PCI busid of the nvidia GPU in form of "PCI:X:0:0" | none | | string |
| nvidia.amdgpuBusId | PCI busid of the amd GPU in form of "PCI:X:0:0" | none | | string |
| **VIRTUALISATION** ||||||
| pciPassthrough.enable | Enable PCI Passthrough | none | [ true false ] | bool |
| pciPassthrough.isolatedDevices | List of isolated devices | none | | list |

