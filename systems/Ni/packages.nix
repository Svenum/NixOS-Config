{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.overrideAttrs (_: { buildInputs = [
        nv-codec-headers
        a52dec
        dav1d
        ffmpeg-hb
        fontconfig
        freetype
        fribidi
        harfbuzz
        jansson
        lame
        libass
        libbluray
        libdvdcss
        libdvdnav
        libdvdread
        libiconv
        libjpeg_turbo
        libogg
        libopus
        libsamplerate
        libtheora
        libvorbis
        libvpx
        libxml2
        speex
        svt-av1
        x264
        x265
        xz
        zimg
      ]; }))
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
