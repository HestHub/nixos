
set shell := ["nu", "-c"]

default:
    @just --list


# update flakes
[group('nix')]
up:
  nix flake update


# rebuild system
[group('nix')]
build:
  sudo nixos-rebuild switch --flake .


# show old profiles
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system


# debug build
[group('nix')]
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
