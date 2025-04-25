<h2 align="center">:snowflake: Hest's Nix Config :snowflake:</h2>

<p align="center">
  <a href="https://nixos.org/">
    <img src="https://img.shields.io/badge/NixOS-unstable-informational.svg?style=for-the-badge&logo=nixos&color=5277C3&logoColor=D9E0EE&labelColor=302D41"
      alt="NixOS">
  </a>
  <a href="https://github.com/nix-community/home-manager">
    <img src="https://img.shields.io/badge/Home_manager-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"
      alt="home-manager">
  </a>
  <a href="https://github.com/nix-darwin/nix-darwin">
    <img src="https://img.shields.io/badge/Nix_Darwin-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"
      alt="nix-darwin">
  </a>
</p>
<p align="center">
<a href="https://github.com/HestHub/nixos/blob/main/LICENSE">
  <img alt="License"
       src="https://img.shields.io/github/license/HestHub/nixos?style=for-the-badge&logo=starship&color=A1C999&logoColor=D9E0EE&labelColor=252733" />
  <img alt="Last commit"
    src="https://img.shields.io/github/last-commit/HestHub/nixos?&style=for-the-badge&color=8D748C&logoColor=D9E0EE&labelColor=252733">
  <img alt="Repo Size"
    src="https://img.shields.io/github/repo-size/HestHub/nixos?color=%23DDB&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=252733">
  </a>
</p>

## 📖 Overview

> This config is tailored to my needs, and is not meant to be a tutorial,
> but if you do find anything you like, feel free to yank it :)

This repository is home to the nix code that builds my systems:

- **NixOS Desktop:** NixOS with Flakes, Home-manager, Sops-Nix, etc.
- **MacOS Laptop:** nix-darwin with home-manager,
  share the same home-manager configuration with NixOS.
- **HomeLab server:** (TODO)
- **Rpi-HomeAssistant:** (TODO)

## 📦 Main Components

| Component                    | NixOS               | MacOS               |
| ------------------- | ------------------- | ------------------- |
| **Color Scheme**    | [Nord]              | [Nord]              |
| **Dev environment** | [direnv] + [devenv] | [direnv] + [devenv] |
| **Editor**          | [Neovim]            | [Neovim]            |
| **File Manager**    | [lf]                | [lf]                |
| **Fonts**           | [Fira Code]         | [Fira Code]         |
| **Input remapper**  | N/A                 | [Kanata]            |
| **Launcher**        | Default             | [Raycast]           |
| **Multiplexer**     | [Zellij]            | [Zellij]            |
| **Shell**           | [Fish] + [Nushell]  | [Fish] + [Nushell]  |
| **Terminal**        | [Ghostty]           | [Ghostty]           |
| **VPN**             | [Tailscale]         | [Tailscale]         |
| **Window Manager**  | [PopShell]          | [Yabai]             |

## 📷 Screenshots

TODO PICTURE

## 🏠 Home Manager

Most of the packages / programs used are installed and configured using home manager.

``` bash
├── core.nix # shared packages
├── darwin.nix # MacOS specific config
├── linux.nix # NixOS specific config 
└── programs # complex or optional config
    ├── ...
```

To evaluate and list installed packages run:

``` bash
nix eval .#nixosConfigurations.nixos.config.home-manager.users.<USERNAME>.home.packages --json | jq
```

## 📂 Modules

- home-manager
- nix-darwin
- sops-nix

``` bash
├── darwin
│   ├── apps.nix # system packages & Homebrew
│   └── system.nix # system settings & MacOS-defaults
└── linux
    ├── configuration.nix # system settings
    └── hardware-configuration.nix # auto generated
```

To evaluate the packages installed system-wide:

``` bash
nix eval .#darwinConfigurations.<HOST>.config.environment.systemPackages --json | jq
```

## ✏️ Editor

[NeoVim](https://neovim.io/) is configured directly in this repo and symlinked to
`$XDG_CONFIG_HOME/nvim` when built.

// TODO PICTURE

Nvim config can be found here => [./dotfiles/nvim/](./dotfiles/nvim/)

## 🖥️ Terminal

[Ghostty](https://ghostty.org/) enabled using `home-manager`

Currently there are some build issues on darwin,
so on darwin, Ghostty is install using Homebrew
and only configured by `home-manager`

`./home/programs/ghostty.nix`

## 🐚 Shell

[Fish](https://fishshell.com/) enabled using `home-manager`

On darwin, the default shell needs to be updated using

`chsh -s /etc/profiles/per-user/hest/bin/fish`

Plugins:

- [autopair](https://github.com/jorgebucaran/autopair.fish)
- [done](https://github.com/franciscolourenco/done)
- [fzf](https://github.com/PatrickF1/fzf.fish)
- [grc](https://github.com/oh-my-fish/plugin-grc)
- [sponge](https://github.com/meaningful-ooo/sponge)
- [puffer](https://github.com/nickeb96/puffer-fish)

[Nushell](https://www.nushell.sh/) - WIP

## 🔐 Secrets Management

<details>

I manage the secrets used in this repository using [Sops-Nix](https://github.com/Mic92/sops-nix).
The secrets are encrypted and then stored in a private repository
that is then used as a flake input.

All the secrets are encrypted using [age](https://github.com/FiloSottile/age)
and the secrets can only be decrypted
host specific keys, that needs to be generated before initial setup.

### setup sops

For the initial setup a new private repo is used.

Following this
[blog post](https://zohaib.me/managing-secrets-in-nixos-home-manager-with-sops/)
the first step is to create a
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

``` bash
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

To allow a new host to decrypt the secrets, it has to be added as a new sops recipient

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

Another popular, possibly simpler solution is to use
[Agenix](https://github.com/ryantm/agenix) to manage secrets.
Sops demands a somewhat more complex initial setup,
but once in place, the workflow it quite simple.

The primary reason Sops is used over Agenix
is due to some rumblings online that Agenix
needs some workarounds to work well on Darwin.

This might be old hat and not applicable anymore,
but Sops seemed to be the safe choice for Darwin.

</details>

## 📜 Cheatsheet / How to Deploy this Flake?

> :red_circle: **IMPORTANT**: **Do not try to deploy this flake as is :exclamation:
> It will not succeed.** This flake contains my hardware configuration,
> and requires my private secrets repository
> using [Sops-Nix](https://github.com/Mic92/sops-nix) to deploy.
> Only use this repo as a reference to build your own setup

If you like to deploy a flake like this,
read through the code and pick out the pieces
that seems relevant and create your own flake,
or just fork it and remove anything not relevant.
Most important parts to remove is the hardware-configuration for NixOS,
the secrets management in home manager and swap host-names and user-names.

### Bootstrapping

**NixOS:**

```bash

  # clone repo
  git clone https://github.com/HestHub/nixos.git
  
  # fetch tools
  nix-shell -p age just
 
  # create new age key
  mkdir -p ~/.config/sops/age
  age-keygen -o ~/.config/sops/age/keys.txt
  age-keygen -y ~/.config/sops/age/keys.txt

  # (Move key to secret repo & add as recipient)

  # rebuild system
  sudo nixos-rebuild switch --flake .#<HOSTNAME>

  # or deploy via `just`(a command runner with similar syntax to make) & Justfile
  nix-shell -p just
  just build

```

**MacOS:**

```bash

  #install Xcode
  xcode-select --install
  
  # Install nix (Say NO to install determinate)
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

  # install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # clone repo
  git clone https://github.com/HestHub/nixos.git
  
  # fetch tools
  nix-shell -p age just
 
  # create new age key
  mkdir -p ~/.config/sops/age
  age-keygen -o ~/.config/sops/age/keys.txt
  age-keygen -y ~/.config/sops/age/keys.txt

  # (Move key to secret repo & add as recipient)

  # Deploy Dariwn config
  just build

```

## 🚧 Roadmap

- [ ] [Nushell](https://www.nushell.sh/)
- [ ] [Disko](https://github.com/nix-community/disko)
- [ ] Cleanup
- [ ] CI
- [ ] Move scripts to repo
- [ ] Security hardening
- [ ] adding server to combined config
- [ ] expanding secrets management

## 🔗 Useful links

Good reads and dotfiles that inspired me:

- Nix Flakes
  - [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config) + [NixOS and Flakes](https://nixos-and-flakes.thiscute.world/preface)
  - [gvolpe/nix-config](https://github.com/gvolpe/nix-config)
  - [Mic92/dotfiles](https://github.com/Mic92/dotfiles)
  - [nix-community/srvos](https://github.com/nix-community/srvos)
  - [1amSimp1e/dots](https://github.com/1amSimp1e/dots)
  - [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config)
  - [budimanjojo/nix-config](https://github.com/budimanjojo/nix-config)
  - [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
  - [Awesome-nix](https://github.com/nix-community/awesome-nix)
- NeoVim/LazyVim
  - [LazyVim distro](https://www.lazyvim.org/)
  - [LazyVim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-1/)
  
[PopShell]:https://github.com/pop-os/shell
[Yabai]:https://github.com/koekeishiya/yabai
[Ghostty]:https://ghostty.org/
[Zellij]:https://zellij.dev/
[Raycast]:https://www.raycast.com/
[Nord]:https://www.nordtheme.com/
[Tailscale]:https://tailscale.com/
[Kanata]:https://github.com/jtroo/kanata
[lf]:https://github.com/gokcehan/lf
[Fish]:https://fishshell.com/
[Nushell]:https://www.nushell.sh/
[Neovim]:https://neovim.io/
[Fira Code]:https://github.com/tonsky/FiraCode
[direnv]:https://direnv.net/
[devenv]:https://devenv.sh/
