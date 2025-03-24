set shell := ["nu", "-c"]

default:
    @just --list


# update flakes
[group('nix')]
[linux]
update:
  nix flake update


# rebuild system
[group('nix')]
[linux]
build:
  sudo nixos-rebuild switch --flake .

alias b := build

# show old profiles
[group('nix')]
[linux]
history:
  nix profile history --profile /nix/var/nix/profiles/system


# debug build
[group('nix')]
[linux]
debug:
  nixos-rebuild switch --flake . --show-trace --verbose


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
