{ lib, ... }:

{
  # looking-glass config
  xdg.configFile."looking-glass/client.ini" = {
     text = lib.generators.toINI {}{
      wayland = { fractionScale = "yes"; };
      opengl = { amdPinnedMem = "yes"; };
      input = {
        rawMouse = "yes";
        autoCapture = "yes";
        captureOnly = "yes";
        escapeKey = "KEY_F12";
      };
      spice = {
        enable = "yes";
        clipboard = "yes";
        audio = "yes";
      };
      app = { shmFile = "/dev/shm/looking-glass-sven"; };
    };
  };
}
