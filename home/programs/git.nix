{
  pkgs,
  config,
  ...
}: {
  xdg.configFile."git/templates/hooks/pre-commit" = {
    enable = true;
    text = ''
      #!/bin/sh

      echo "Running gitleaks check..."
      gitleaks git --pre-commit --staged

      # Check the exit code of the gitleaks command
      if [ $? -ne 0 ]; then
          echo "Gitleaks found issues or failed to run"
          exit 1
      fi

      echo "Gitleaks check passed"

      echo "Running trufflehog check..."
      trufflehog git file://. --since-commit HEAD --results=verified,unknown --fail

      # Check the exit code of the trufflehog command
      if [ $? -ne 0 ]; then
          echo "Trufflehog found issues or failed to run"
          exit 1
      fi

      echo "All security checks passed"
      exit 0 '';
    executable = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    includes =
      if pkgs.stdenv.isDarwin
      then [
        {
          condition = "gitdir:~/dev/me/";
          path = "${config.home.homeDirectory}/.config/git/include_me";
        }
        {
          condition = "gitdir:~/dev/c*/";
          path = "${config.home.homeDirectory}/.config/git/include_c";
        }
        {
          condition = "gitdir:~/dev/g*/";
          path = "${config.home.homeDirectory}/.config/git/include_g";
        }
      ]
      else [
        {
          condition = "gitdir:~/dev/";
          path = "${config.home.homeDirectory}/.config/git/include_me";
        }
      ];

    settings = {
      init.defaultBranch = "main";
      init.templateDir = "${config.xdg.configHome}/git/templates";
      push.autoSetupRemote = true;
      pull.rebase = true;
      alias = {
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
    };

    ignores = [
      "!.vscode/extensions.json"
      "!.vscode/launch.json"
      "!.vscode/settings.json"
      "!.vscode/tasks.json"
      "!flake.lock"
      ".classpath"
      ".devcontainer/"
      ".devenv*"
      ".direnv"
      ".env"
      ".envrc"
      ".flattened-pom.xml"
      ".gradle/"
      ".idea/"
      ".metals*"
      ".mise.toml"
      ".pre-commit-config.yaml"
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
      "devenv.local.nix"
      "devenv.nix"
      "obj/"
      "old-gc/"
      "out/"
      "**/.DS_Store"
    ];
  };
}
