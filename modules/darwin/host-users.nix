{...} @ args: let
  hostname = "mbp";
  username = "hest";
in {
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
    shell = "/run/current-system/sw/bin/fish";
  };

  nix.settings.trusted-users = [username];
}
