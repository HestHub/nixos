{pkgs, ...}: {
  cachix.enable = false;
  dotenv.enable = true;
  packages = [pkgs.git];

  languages = {
    nix.enable = true;
    lua.enable = true;
  };
}
