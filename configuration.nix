{ config, pkgs, ... }:

{
  # Dil və zaman 
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Baku";  

  # Xfce masaüstü mühitini aktivləşdiririk
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Faydalı proqramları quraşdırırıq
  environment.systemPackages = with pkgs; [
    vim
    nano
    git
    docker
    python39
    nodejs
    npm
    go
    jq
    tmux
    xfce
  ];

  # Docker xidmətini aktivləşdiririk
  virtualisation.docker.enable = true;

  # SSH xidmətini aktivləşdiririk
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "prohibit-password"; # Root loginini şifrə ilə məhdudlaşdırır

  # Nginx xidmətini aktivləşdiririk
  services.nginx.enable = true;

  # Firewall konfiqurasiyası
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];  

  # Unfree paketlərə icazə verir
  nixpkgs.config.allowUnfree = true;

  # Swap istifadə etmirik
  swapDevices = [];  # Swap deaktiv edilir

  # Kernel modulları və parametrlər
  boot.kernelModules = [ "kvm-intel" "vhost-net" ];  # Virtualizasiya dəstəyi
  boot.kernelParams = [ "iommu=pt" ];  # IOMMU parametri
}

