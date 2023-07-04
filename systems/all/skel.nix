{ ... }:

{
  environment.etc."skel" = ../../skel;
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";
}
