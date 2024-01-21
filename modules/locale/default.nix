{ settings, ... }:

{
  # Load locales
  imports = [ ./${settings.locale}.nix ];

  # Configure Timezone
  time.timeZone = settings.tz;
  
  # Configure Keyboard layout
  console.useXkbConfig = true;
}
