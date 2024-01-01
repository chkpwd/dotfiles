{
  description = "Chkpwd's Flakes";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  inputs.nixoswsl.url = "github:nix-community/NixOS-WSL";
  inputs.nixoswsl.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager/release-23.11";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.vscode-server.url = "github:nix-community/nixos-vscode-server";
  inputs.vscode-server.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    nixpkgs,
    nixoswsl,
    home-manager,
    vscode-server,
    ...
  }: let
    username = "chkpwd";
    systemname = "chk-dev-nixos"; # TODO: Look into '#' deriviation
  in {
    nixosConfigurations.${systemname} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixoswsl.nixosModules.wsl
        vscode-server.nixosModules.default
        home-manager.nixosModules.home-manager
        # homemanager inline
        (
          {pkgs, ...}: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = {
              home.username = username;
              home.homeDirectory = "/home/${username}";
              home.stateVersion = "23.11"; #TODO: Look into this
              home.packages = with pkgs; [
                alejandra # nix formatter
                nil # nix language server
                # Development
                istio
                fluxcd
                hugo
                etcd
                packer
                govc
                #kairos
                yt-dlp
                #korb
                atuin
                bws
                bitwarden-cli
                pet
                teller
                chezmoi
                stern
                viddy
                k9s
                terraform
                sops
                vcluster
                nova
                pluto
                kubectl
                krew
                kubens
                kubernetes-helm
                unzip
                pwgen
                git
                vim
                jq
                yq
                rsync
                rclone
                pkg-config
                go
                nodejs
                upx
                jqp
                #alien
                sshpass
                nmap
                drill
                traceroute
                dnsutils
                ipcalc
                #genisoimage
                bat
                fzf
                tree
                #zsh
                direnv
                age
                hugo
                ffmpeg
                # Ansible
                (python311.withPackages (ps: [
                  ps.ansible-core
                  ps.molecule
                ]))
                ansible-lint
              ];
              programs.home-manager.enable = true;
            };
          }
        )
        # wsl inline
        (
          {pkgs, ...}: {
            wsl = {
              enable = true;
              defaultUser = username;
              # workaround for vscode remoting
              extraBin = with pkgs; [
                {src = "${coreutils}/bin/uname";}
                {src = "${coreutils}/bin/dirname";}
                {src = "${coreutils}/bin/readlink";}
              ];
            };
          }
        )
        # nixos inline
        (
          {pkgs, ...}: {
            system = {
              stateVersion = "23.11"; #TODO: Look into this
            };
            environment.systemPackages = with pkgs; [
              btop
              htop
              wget
              dnsutils
              vim
              unzip
            ];
            nix = {
              settings.experimental-features = ["nix-command" "flakes"];
              gc.automatic = true;
              gc.options = "--delete-older-than 7d";
            };
            networking.hostName = systemname;
          }
        )
        # vscode remoting inline
        (
          {pkgs, ...}: {
            programs.nix-ld.enable = true;
            services.vscode-server.enable = true;
          }
        )
      ];
    };
  };
}
