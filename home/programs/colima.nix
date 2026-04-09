{config, ...}: {
  home.activation.colimaConfig = config.lib.dag.entryAfter ["writeBoundary"] ''
        mkdir -p ${config.home.homeDirectory}/.config/colima/default
        cat > ${config.home.homeDirectory}/.config/colima/default/colima.yaml << 'EOF'
    cpu: 8
    memory: 16
    disk: 100
    arch: aarch64
    runtime: docker
    vmType: vz
    rosetta: true
    binfmt: true
    mounts: []
    mountType: virtiofs
    mountInotify: true
    autoActivate: true
    sshConfig: true
    portForwarder: ssh
    EOF
  '';
}
