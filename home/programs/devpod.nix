{config, pkgs, ...}: {
  home.activation.devpod = config.lib.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${pkgs.devpod}/bin/devpod provider use docker \
      --option DOCKER_HOST=unix://${config.home.homeDirectory}/.config/colima/default/docker.sock \
      --option INACTIVITY_TIMEOUT=20m \
      --silent || true

    $DRY_RUN_CMD ${pkgs.devpod}/bin/devpod ide use none --silent || true
  '';
}
