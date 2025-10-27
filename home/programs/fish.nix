let
  insultfunction = builtins.readFile ./fish-functions/insulter.fish;
in
  {
    pkgs,
    config,
    ...
  }: {
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

        set -gx GEMINI_API_KEY $(cat ${config.sops.secrets."gemini".path})
      '';

      interactiveShellInit = ''
        insulter

        zellij_tab_cmd
        zellij_tab_dir

        if status is-interactive
          eval (zellij setup --generate-auto-start fish | string collect)
        end

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
        c = "clear";

        lgi = "lazygit";
        ldo = "lazydocker";
        lsq = "lazysql";

        cat = "bat";
        lf = "yazi";

        vi = "nvim";
        vim = "nvim";
        e = "nvim";

        cp = "cp -i";
        rm = "rm -i";

        gfp = "git fetch && git pull";
        gitbt = "git log --graph --simplify-by-decoration --pretty=format:'%d' --all";

        ls = "eza -1 -F --group-directories-first";
        lsa = "eza -1 -F --group-directories-first -a";
        ll = "eza -1 -F --group-directories-first -l --git --classify --no-user ";
        lla = "eza -1 -F --group-directories-first -l -a --git --classify --no-user ";
        lt = "eza -1 -F -T";
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

        # TODO, mark with Symbol
        # vim / Gemini/ Yazi, K9s, lazyDocker, lazyGit
        zellij_tab_cmd = {
          onEvent = "fish_preexec";
          body = ''
            if set -q ZELLIJ
                if test -n "$argv"
                    set command $argv[1]
                    set dirname (basename "$PWD")

                    if [ "$PWD" = "$HOME" ]
                        set dirname "~"
                    end

                    switch "$command"
                        case nvim vim
                            zellij action rename-tab " $dirname"
                        case gemini
                            zellij action rename-tab "󰪁 $dirname"
                        case yazi
                            zellij action rename-tab "󰍉 $dirname"
                        case k9s
                            zellij action rename-tab "󱃾 $dirname"
                        case lazygit
                            zellij action rename-tab "󰊢 $dirname"
                        case lazydocker
                            zellij action rename-tab "󰡨 $dirname"
                        case '*'

                    end
                end
            end
          '';
        };

        zellij_tab_dir = {
          onEvent = "fish_prompt";
          body = ''
            if set -q ZELLIJ
                set dirname (basename "$PWD")

                if [ "$PWD" = "$HOME" ]
                    set dirname "~"
                end

                zellij action rename-tab " $dirname"
            end
          '';
        };

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
          inherit (pkgs.fishPlugins.autopair) src;
        }
        {
          name = "done";
          inherit (pkgs.fishPlugins.done) src;
        }
        {
          name = "fzf";
          inherit (pkgs.fishPlugins.fzf) src;
        }
        {
          name = "grc";
          inherit (pkgs.fishPlugins.grc) src;
        }
        {
          name = "sponge";
          inherit (pkgs.fishPlugins.sponge) src;
        }
        {
          name = "puffer";
          inherit (pkgs.fishPlugins.puffer) src;
        }
      ];
    };
  }
