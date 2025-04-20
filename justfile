set shell := ["nu", "-c" ]

default:
    @just --list


# update flakes
[group('nix')]
update:
  nix flake update
  nvim --headless "+Lazy! sync" +qa

# rebuild system
[group('nix')]
[linux]
build:
  sudo nixos-rebuild switch --flake .


# rebuild system
[group('nix')]
[macos]
build:
  nix build .#darwinConfigurations.mbp.system --extra-experimental-features 'nix-command flakes'
  ./result/sw/bin/darwin-rebuild switch --impure --flake .#mbp
alias b := build

# debug build
[group('nix')]
[linux]
debug:
  nixos-rebuild switch --flake . --show-trace --verbose

# bootstrap darwin system
[group('nix')]
[macos]
bootstrap:
  # 	install nix 
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  # 	install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# setup ssh keys 
[group('nix')]
[macos]
ssh_keys:
  ssh-add --apple-use-keychain ~/.ssh/id_me
  ssh-add --apple-use-keychain ~/.ssh/id_c
  ssh-add --apple-use-keychain ~/.ssh/id_g


# show old profiles
[group('nix')]
[linux]
history:
  nix profile history --profile /nix/var/nix/profiles/system



# remove old profiles
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d


# gc system and user nix store
[group('nix')]
gc:
  sudo nix-collect-garbage --delete-older-than 7d
  nix-collect-garbage --delete-older-than 7d


# verify nix store Objects
[group('nix')]
verify-store:
  nix store verify --all


# Repair Nix Store Objects
[group('nix')]
repair-store *paths:
  nix store repair {{paths}}

system-info:
    @echo "CPU architecture: {{ arch() }}"
    @echo "Operating system type: {{ os_family() }}"
    @echo "Operating system: {{ os() }}"
    @echo "Home directory: {{ home_directory() }}"
