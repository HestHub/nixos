{gitIncludes ? [], ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    diff-so-fancy.enable = true;

    includes = gitIncludes;

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    aliases = {
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      amend = "commit --amend -m";

      # aliases for submodule
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
    ignores = [
      "!.vscode/extensions.json"
      "!.vscode/launch.json"
      "!.vscode/settings.json"
      "!.vscode/tasks.json"
      "!flake.lock"
      ".classpath"
      ".env"
      ".flattened-pom.xml"
      ".gradle/"
      ".idea/"
      ".mise.toml"
      ".project"
      ".rtx.toml"
      ".vscode/*"
      "*.code-workspace"
      "*.iml"
      "*.lock"
      "*.settings"
      "*.tgz"
      "bin/"
      "build/"
      "out/"
      "**/.DS_Store"
      ".devenv*"
      "devenv.local.nix"
      ".direnv"
      ".pre-commit-config.yaml"
      ".devenv*"
      "devenv.local.nix"
      ".direnv"
      ".pre-commit-config.yaml"
      ".devenv*"
      "devenv.local.nix"
      ".direnv"
      ".pre-commit-config.yaml"
      ".envrc"
      "devenv.nix"
    ];
  };
}
