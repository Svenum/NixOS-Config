{ locale, tz, kbLayout, ... }:

{
  # Load locales
  imports = [ ./${locale}.nix ];

  # Configure Timezone
  time.timeZone = tz;
  
  # Configure Keyboard layout
  console.useXkbConfig = true;
}
