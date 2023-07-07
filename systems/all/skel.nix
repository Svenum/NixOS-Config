{ ... }:

{
  environment.etc."skel".source = ../../skel;
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";
}
