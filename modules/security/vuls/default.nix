{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.vuls;
in
{
  meta.maintainers = [
    lib.maintainers.kashw2 or "kashw2"
  ];

  options = {
    services.vuls = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable Vuls";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.vuls ];
    launchd.daemons.vuls = {
      path = [ pkgs.vuls ];
      command = "${pkgs.vuls}/bin/vuls server";
      serviceConfig.KeepAlive = true;
      serviceConfig.RunAtLoad = true;
    };
  };
}
