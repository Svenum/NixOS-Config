{ ... }:

{
  environment.etc."skel".source = ../../skel;
  environment.etc."skel".mode = "0640";
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";
}
