{pkgs, ...}: {
  dotenv.enable = true;
  packages = [pkgs.just];

  languages = {
    nix.enable = true;
    lua.enable = true;
    shell.enable = true;
  };
}
