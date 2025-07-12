let
  insultfunction = builtins.readFile ./fish-functions/insulter.fish;
in
  {pkgs, ...}: {
    home.packages = with pkgs; [
      fish
      fzf
      grc
      fishPlugins.autopair
      fishPlugins.colored-man-pages
      fishPlugins.done
      fishPlugins.fzf
      fishPlugins.grc
      fishPlugins.sponge
      fishPlugins.puffer
    ];

    programs.fish = {
      enable = true;

      shellInit = ''
        # Check if the operating system is macOS (Darwin)
        if test (uname) = "Darwin"
          # Set DOTNET_ROOT only on macOS
          set -gx DOTNET_ROOT (dirname (realpath (which dotnet)))
          fish_add_path /opt/homebrew/bin
        end
      '';

      interactiveShellInit = ''
        insulter

        set fish_greeting # Disable greeting

        abbr -a -- .. "cd .."
        abbr -a -- ... "cd ../.."
        abbr -a -- .... "cd ../../.."
        abbr -a -- ..... "cd ../../../.."
        abbr -a -- - "cd -"
      '';
      shellAbbrs = {
        k = "kubectl";
        g = "git";
        cd = "z";
        j = "z";
        lg = "lazygit";
        lzd = "lazydocker";
        ldo = "lazydocker";
        lq = "lazysql";
        cat = "bat";
        vi = "nvim";
        vim = "nvim";
        gfp = "git fetch && git pull";
        ls = "eza -1 -F --group-directories-first";
        lsa = "eza -1 -F --group-directories-first -a";
        ll = "eza -1 -F --group-directories-first -l --git";
        lla = "eza -1 -F --group-directories-first -l -a --git";
        lt = "eza -1 -F -T";
        gitbt = "git log --graph --simplify-by-decoration --pretty=format:'%d' --all";
        azlistdev = "az containerapp list --subscription ${builtins.getEnv "AZ_SUB_DEV"} --resource-group ${builtins.getEnv "AZ_RG_DEV"} | jq '.[] | \"\\(.properties.runningStatus) \\(.name)\"'";
        azlistprod = "az containerapp list --subscription ${builtins.getEnv "AZ_SUB_PROD"} --resource-group ${builtins.getEnv "AZ_RG_PROD"} | jq '.[] | \"\\(.properties.runningStatus) \\(.name)\"'";
        azdev = "az containerapp logs show --subscription ${builtins.getEnv "AZ_SUB_DEV"} --resource-group ${builtins.getEnv "AZ_RG_DEV"} --follow --format text -n";
        azprod = "az containerapp logs show --subscription ${builtins.getEnv "AZ_SUB_PROD"} --resource-group ${builtins.getEnv "AZ_RG_PROD"} --follow --format text -n";
      };

      functions = {
        update_git = ''
          set back (pwd)
          for d in (find . -type d -name .git)
            cd "$d/.."
            pwd
            git pull
            cd $back
          end
        '';

        gcp = ''
          git add .
          git commit -m "$argv"
          git push origin HEAD
        '';

        insulter = insultfunction;

        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      };

      plugins = [
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf.src;
        }
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge.src;
        }
        {
          name = "puffer";
          src = pkgs.fishPlugins.puffer.src;
        }
      ];
    };
  }
