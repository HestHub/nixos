
<h2 align="center">:snowflake: Hest's Nix Config :snowflake:</h2>

<p align="center">
  <span title="nord0: #2E3440" style="background-color: #2E3440; color: #2E3440;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord1: #3B4252" style="background-color: #3B4252; color: #3B4252;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord2: #434C5E" style="background-color: #434C5E; color: #434C5E;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord3: #4C566A" style="background-color: #4C566A; color: #4C566A;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord4: #D8DEE9" style="background-color: #D8DEE9; color: #D8DEE9;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord5: #E5E9F0" style="background-color: #E5E9F0; color: #E5E9F0;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord6: #ECEFF4" style="background-color: #ECEFF4; color: #ECEFF4;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord7: #8FBCBB" style="background-color: #8FBCBB; color: #8FBCBB;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord8: #88C0D0" style="background-color: #88C0D0; color: #88C0D0;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord9: #81A1C1" style="background-color: #81A1C1; color: #81A1C1;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord10: #5E81AC" style="background-color: #5E81AC; color: #5E81AC;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord11: #BF616A" style="background-color: #BF616A; color: #BF616A;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord12: #D08770" style="background-color: #D08770; color: #D08770;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord13: #EBCB8B" style="background-color: #EBCB8B; color: #EBCB8B;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord14: #A3BE8C" style="background-color: #A3BE8C; color: #A3BE8C;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span title="nord15: #B48EAD" style="background-color: #B48EAD; color: #B48EAD;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
</p>

<p align="center">
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-unstable-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
  <a href="https://github.com/nix-community/home-manager">
        <img src="https://img.shields.io/badge/Home_manager-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
  <a href="https://github.com/nix-darwin/nix-darwin">
        <img src="https://img.shields.io/badge/Nix_Darwin-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
  </a>

</p>

<p align="center">
<a href="https://github.com/HestHub/nixos/blob/main/LICENSE">
  <img alt="License" src="https://img.shields.io/github/license/HestHub/nixos?style=for-the-badge&logo=starship&color=A1C999&logoColor=D9E0EE&labelColor=252733" />
</a>
<img alt="Last commit" src="https://img.shields.io/github/last-commit/HestHub/nixos?&style=for-the-badge&color=8D748C&logoColor=D9E0EE&labelColor=252733">
<img alt="Repo Size" src="https://img.shields.io/github/repo-size/HestHub/nixos?color=%23DDB&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=252733">

</p>

</div>

</br>
</br>

> This config is tailored to my needs, and is not meant to be a tutorial, but if you do find
> anything you like, feel free to yank it :)

This repository is home to the nix code that builds my systems:

1. NixOS Desktop: NixOS with Flakes, Home-manager, Sops-Nix, etc.
2. macOS Laptop: nix-darwin with home-manager, share the same home-manager configuration with
   NixOS.
3. HomeLab server (Todo)
4. Rpi-HomeAssistant (Todo)

## Main Components

|                             | NixOS                                   | MacOS|
| --------------------------- | ---------------------------------------------- | ------------- |
| **Window Manager**          | [PopShell](https://github.com/pop-os/shell)    | [Yabai](https://github.com/koekeishiya/yabai)  |
| **Terminal Emulator**       | [Zellij](https://zellij.dev/) + [Ghostty](https://ghostty.org/) | [Zellij](https://zellij.dev/) + [Ghostty](https://ghostty.org/)                                                           |
| **Application Launcher**    | Default                             | [Raycast](https://www.raycast.com/)                                                                     |
| **Color Scheme**            | [Nord](https://www.nordtheme.com/)             | [Nord](https://www.nordtheme.com/)                                                                  |
| **VPN**                     | [Tailscale](https://tailscale.com/)            | [Tailscale](https://tailscale.com/)                                                                    |
| **Input remapper**          | N/A                                            |    [Kanata](https://github.com/jtroo/kanata)                                                                 |
| **File Manager**            | [lf](https://github.com/gokcehan/lf)           | [lf](https://github.com/gokcehan/lf)                                                                     |
| **Shell**                   | [Fish](https://fishshell.com/) + [Nushell](https://www.nushell.sh/)     | [Fish](https://fishshell.com/) + [Nushell](https://www.nushell.sh/)                                                                     |
| **Text Editor**             | [Neovim](https://neovim.io/)                   | [Neovim](https://neovim.io/)                                                                     |
| **Fonts**                   | [Fira Code](https://github.com/tonsky/FiraCode)| [Fira Code](https://github.com/tonsky/FiraCode)      |
| **Image Viewer**            | [viu](https://github.com/atanunq/viu)          | [viu](https://github.com/atanunq/viu)  |
| **Dev environment**         | [direnv](https://direnv.net/) + [devenv](https://devenv.sh/) | [direnv](https://direnv.net/) + [devenv](https://devenv.sh/) |

## Screenshots

TODO PICTURE

## Home Manager

Most of the packages / programs used are installed and configured using home manager.

``` bash
├── core.nix
├── darwin.nix
├── linux.nix
└── programs
    ├── ...
```

The home directory is structured to contain a core file that contains packages used by all (both) hosts.

Specific configuration per host is store in respective file and imports both core and any useful program config located in the programs directory.

- **core** shared config

- **darwin** host specific config

- **linux** host specific config

- **programs/*** complex or optional config

To evaluate and list everything installed run:

``` bash
# in general
nix eval .#nixosConfigurations.nixos.config.home-manager.users.<HOSTNAME>.home.packages --json | jq

# for this repo
nix eval .#nixosConfigurations.nixos.config.home-manager.users.hest.home.packages --json | jq

```

## Modules

### System configuration per host

- **Darwin/system**, manage settings related to user, networking and nix config, as well as MacOS [defaults](https://macos-defaults.com/)

- **Darwin/apps** manage some system wide services (Yabai/Skhd) and homebrew packages are installed here, since homebrew is managed as a nix-darwin module.

- **Linux/config** manages Gnome environment, some user config and system settings to enable virtualisation et.c

- **Linux/hardware** is an auto generated file based on system hardware.

```
├── darwin
│   ├── apps.nix
│   └── system.nix
└── linux
    ├── configuration.nix
    └── hardware-configuration.nix
```

To evaluate the packages installed system-wide:

``` bash
# in general
nix eval .#darwinConfigurations.<HOST>.config.environment.systemPackages --json | jq

# for this NixOS system
nix eval .#darwinConfigurations.nixos.config.environment.systemPackages --json | jq

# for this Darwin system
nix eval .#darwinConfigurations.mbp.config.environment.systemPackages --json | jq
```

## Secrets Management

I manage the secrets used in this repository using [Sops-Nix](https://github.com/Mic92/sops-nix).
The secrets are encrypted and then stored in a private repository
that is then used as a flake input.

All the secrets are encrypted using [age](https://github.com/FiloSottile/age)
and the secrets can only be decrypted
host specific keys, that needs to be generated before initial setup.

### setup sops

For the initial setup a new private repo is used.

Following this [blogpost](https://zohaib.me/managing-secrets-in-nixos-home-manager-with-sops/) the first step is to create a
host specific age key file that is used encrypt/decrypt.

``` bash
mkdir -p ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt # generate key
age-keygen -y ~/.config/sops/age/keys.txt # fetch public key
```

To generate secrets, sops need a blueprint file to know what to do:

In the private repo create `.sops.yaml`

``` yaml
keys:
  - &host1 <YOUR PUBLIC KEY>
creation_rules:
  - path_regex: secrets.yaml$
    key_groups:
    - age:
      - *host1
```

Once the age file and sops blueprint is in place,
modifying sops secrets are done using the sops CLI

```
# if sops is not installed yet
nix-shell -p sops --run "sops secrets.yaml"

# if sops already in place
sops secrets.yaml
```

This will open a decrypted `secrets.yaml` file that can be edited freely.
On closing the file, sops will re-encrypt the file, making it safe to store/send.

### using secrets

To use sops secrets in the flake, the first step is to import the sops module
as well as the private repo as a flake.

`flake.nix`

``` Nix
inputs = {
  sops-nix.url = "github:Mic92/sops-nix";

  dot-secrets = {
    url = "git+ssh://git@github.com/HestHub/dot-secrets.git";
    flake = false;
  };
};
...
# include sops module in home manager

home-manager.darwinModules.home-manager
{
  ...
  home-manager.sharedModules = [
    sops-nix.homeManagerModules.sops
  ];
  ...
}

```

Then in the home-manager config, sops can be used to pick out
and decrypt any defined secrets.
Sops will create new files with the content found in the `secrets.yaml` file

``` Nix
  sops = {
    # select key to use for decryption
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    # select file to decrypt from secrets repo
    defaultSopsFile = "${inputs.dot-secrets}/secrets.yaml";
    
    secrets = {
      # create new file from the secret used
      "ssh/key".path = "${config.home.homeDirectory}/.ssh/id_X";
    };
  };
```

### adding new hosts

to allow a new host to decrypt the secrets, it has to be added as a new sops recipiant

``` yaml
keys:
  - &host1 <YOUR PUBLIC KEY>
  - &host2 <SECOND PUBLIC KEY>
creation_rules:
  - path_regex: secrets.yaml$
    key_groups:
      - age: [*host1, *host2]
```

With the new host key in place, `sops updatekeys secrets.yaml`
will add `host2` key as a new recipient

### alternatives

Another popular, possibly simpler solution is to use [Agenix](https://github.com/ryantm/agenix) to manage secrets.
Sops demands a somewhat more complex initial setup, but once in place, the workflow it quite simple.

The primary reason Sops is used over Agenix
is due to some rumblings online that Agenix
needs some workarounds to work well on Darwin.

This might be old hat and not applicable anymore,
but Sops seemed to be the safe choice for Darwin.

## Neovim

look here => [./dotfiles/nvim/](./dotfiles/nvim/)

## How to Deploy this Flake?

<!-- prettier-ignore -->
> :red_circle: **IMPORTANT**: **Do not try to deploy this flake as is :exclamation:
> It will not succeed.** This flake contains my hardware configuration,
> and requires my private secrets repository
using [Sops-Nix](https://github.com/Mic92/sops-nix) to deploy.
> Only use this repo as a reference to build your own setup

If you like to deploy a flake like this,
read through the code and pick out the pieces
that seems relevant and create your own flake,
or just fork it and remove anything not relevant.
Most important parts to remove is the hardware-configuration for NixOS,
the secrets management in home manager and swap host-names and user-names.

**For NixOS:**

```bash
# grab the pieces you like and build your own flake
  
  sudo nixos-rebuild switch --flake .#<HOSTNAME>

# or deploy via `just`(a command runner with similar syntax to make) & Justfile
  
  nix-shell -p just nushell
  just build

```

**For macOS:**

```bash

# 1. grab the pieces you like and build your own flake
#
# If you are deploying for the first time,
#   - login to apple account if you want to install app store apps using homebrew (homebrew.masApps.*)
#   - install nix & homebrew manually. 
#       if you are using determinate systems, make sure to say NO when asked to install `Determinate Nix`
#       otherwise nix darwin can't update `nix.*` config
#
# 2. prepare the deployment environment with essential packages available
  
  nix-shell -p just nushell

# 3. update just script to use your hostname
#
# 4. deploy Dariwn config

  just build

```

## Roadmap

- [ ] Cleanup
- [ ] Move scripts to repo
- [ ] Security hardening
- [ ] adding server to combined config
- [ ] expanding secrets management

## Useful links

Good reads and dotfiles that inspired me:

- Nix Flakes
  - [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config) + [NixOS and Flakes](https://nixos-and-flakes.thiscute.world/preface)
  - [gvolpe/nix-config](https://github.com/gvolpe/nix-config)
  - [Mic92/dotfiles](https://github.com/Mic92/dotfiles)
  - [nix-community/srvos](https://github.com/nix-community/srvos)
  - [1amSimp1e/dots](https://github.com/1amSimp1e/dots)
- Neovim/Lazyvim
  - [LazyVim distro](https://www.lazyvim.org/)
  - [LazyVim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-1/)
