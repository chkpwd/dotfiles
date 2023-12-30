{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    devShell.x86_64-linux = pkgs.mkShell {
      shellHook = ''
        ${pkgs.zsh}/bin/zsh
      '';
      packages = with pkgs;  [
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
        less
        pwgen
        git
        vim
        htop
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
    };
  };
}
