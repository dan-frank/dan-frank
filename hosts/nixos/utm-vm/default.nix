{ pkgs, ... }: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")

    ./../../common.nix
    ./../../packages.nix
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "usbhud" "usb_storage" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Copy from `/etc/nixos/hardware-configurations.nix`
  fileSystems = {
    "/" = { 
      device = "/dev/disk/by-uuid/918111de-0d4f-428a-b69f-45aa768316c4";
      fsType = "ext4";
    };
  };

  # Copy from `/etc/nixos/hardware-configurations.nix`
  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEft = 2;
  boot.loader.grub.device = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.useDHCP = false;
  # networking.interfaces.ens33.useDHCP = true;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the XFCE Desktop Environment
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;

    # Configure keymap in X11
    services.xserver = {
      layout = "gb";
      xkbVariant = "mac";
    };
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager.)
  # services.xserver.libinput.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "dan";

  environment = {
    # pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      wget
      firefox
    ];
  };

  # Some programs need SUID wrappers, can be cofigured further or are
  # started in user sessions.
  # programs = {
  #   mtr.enable = true;
  #   gnupg.agent = {
  #     enable = true;
  #     enableSSHSupport = true;
  #   };
  # };

  # services = {
  #   pcscd.enable = true;
  #   xserver = {
  #     enable = true;
  #     windowManager.i3 = {
  #       enable = true;
  #       extraPackages = with pkgs; [
  #         dmenu
  #         i3status
  #         i3lock
  #       ];
  #     };
  #     displayManager.defaultSession = "none+i3";
  #   };
  # };

  # Setup QEMU virtualisation
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  systemd.services.spice-vdagentd = {
    description = "spice-vdagent daemon";
    wantedBy = [ "graphical.target" ];
    preStart = ''
      mkdir -p "/run/spice-vdagentd/"
    '';
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagentd";
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
}
