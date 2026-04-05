{lib, ...}: {
  home.file.".ssh/config_nix".text = ''
    Host *.devpod
      StrictHostKeyChecking no
      UserKnownHostsFile /dev/null
      LogLevel ERROR

    Host *
      ForwardAgent no
      AddKeysToAgent yes
      Compression no
      ServerAliveInterval 0
      ServerAliveCountMax 3
      HashKnownHosts no
      UserKnownHostsFile ~/.ssh/known_hosts
      ControlMaster no
      SetEnv TERM=xterm-256color
      ControlPath ~/.ssh/master-%r@%n:%p
      ControlPersist no
  '';
  home.activation.setupMutableSSH = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"

    touch "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"

    if ! grep -q "Include ~/.ssh/config_nix" "$HOME/.ssh/config"; then
      # Write the Include to a temp file, append the existing DevPod config, and replace
      echo "Include ~/.ssh/config_nix" > "$HOME/.ssh/config.tmp"
      cat "$HOME/.ssh/config" >> "$HOME/.ssh/config.tmp"
      mv "$HOME/.ssh/config.tmp" "$HOME/.ssh/config"
      chmod 600 "$HOME/.ssh/config"
    fi
  '';
}
