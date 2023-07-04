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
│   ├── .config
│   │   ├── auroraerc
│   │   ├── kcminputrc
│   │   ├── kdedefaults
│   │   │   ├── kcminputrc
│   │   │   ├── kdeglobals
│   │   │   ├── kglobals
│   │   │   ├── kscreenlockerrc
│   │   │   ├── ksplashrc
│   │   │   ├── kwinrc
│   │   │   ├── package
│   │   │   └── plasmarc
│   │   ├── kdeglobals
│   │   ├── kglobalshortcutsrc
│   │   ├── kscreenlockerrc
│   │   ├── ksplashrc
│   │   ├── kwinrc
│   │   ├── latte
│   │   │   └── Default.layout.latte
│   │   ├── plasma-localerc
│   │   ├── plasma-org.kde.plasma.desktop-appletsrc
│   │   ├── plasmarc
│   │   ├── plasmashellrc
│   │   └── systemsettingsrc
│   ├── .local
│   │   └── share
│   │       ├── flatpak
│   │       │   └── overrides
│   │       │       ├── com.valvesoftware.Steam
│   │       │       └── global
│   │       └── plasma
│   │           └── plasmoids
│   │               ├── org.kde.plasma.betterinlineclock
│   │               │   ├── AUTHORS
│   │               │   ├── CHANGELOG.md
│   │               │   ├── contents
│   │               │   │   ├── config
│   │               │   │   │   ├── config.qml
│   │               │   │   │   └── main.xml
│   │               │   │   └── ui
│   │               │   │       ├── CalendarView.qml
│   │               │   │       ├── configAppearance.qml
│   │               │   │       ├── configCalendar.qml
│   │               │   │       ├── configTimeZones.qml
│   │               │   │       ├── DigitalClock.qml
│   │               │   │       ├── main.qml
│   │               │   │       ├── MonthMenu.qml
│   │               │   │       └── Tooltip.qml
│   │               │   ├── CREDITS
│   │               │   ├── LICENSE.md
│   │               │   ├── metadata.desktop
│   │               │   ├── metadata.json
│   │               │   └── README.md
│   │               └── org.kde.shutdownOrSwitch
│   │                   ├── contents
│   │                   │   ├── config
│   │                   │   │   ├── config.qml
│   │                   │   │   └── main.xml
│   │                   │   └── ui
│   │                   │       ├── configAppearance.qml
│   │                   │       ├── configGeneral.qml
│   │                   │       ├── FullRepresentation.qml
│   │                   │       ├── js
│   │                   │       │   └── index.js
│   │                   │       ├── ListDelegate.qml
│   │                   │       └── main.qml
│   │                   ├── metadata.desktop
│   │                   └── metadata.json
│   ├── .p10k.zsh
│   └── .zshrc
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
    │   └── user.nix
    ├── Ni
    │   ├── network.nix
    │   └── packages.nix
    ├── San
    │   ├── default.nix
    │   ├── desktop.nix
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
