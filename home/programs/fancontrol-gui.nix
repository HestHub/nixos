{inputs, ...}: {
  imports = [inputs.fancontrol-gui.homeManagerModules.default];

  programs.fancontrol-gui = {
    enable = true;
  };
}
