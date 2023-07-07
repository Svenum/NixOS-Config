{ ... }:

{
  environment.etc."skel" = {
    source = ../../skel;
    mode = "0640";
  };
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";
}
