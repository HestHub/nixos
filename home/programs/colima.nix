{...}: {
  xdg.configFile."colima/default/colima.yaml".text = ''
    cpu: 8
    memory: 16
    disk: 100
    arch: aarch64
    runtime: docker
    vmType: vz
    rosetta: true
    binfmt: true
    mountType: virtiofs
    mountInotify: true
    autoActivate: true
    sshConfig: true
    portForwarder: ssh
  '';
}
