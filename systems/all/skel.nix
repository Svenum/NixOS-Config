{ ... }:

{
  environment.etc."skel".source = ../../skel;
  environment.etc."skel".mode = "0600";
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";
}
