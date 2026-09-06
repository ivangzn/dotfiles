{ config, pkgs, ... }:

{
  # Enable OpenGL / Hardware Acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  # Load Nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required for Wayland compositors (like Niri & Hyprland)
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend issues.
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with nouveau).
    # Set false for modern desktop cards (e.g. RTX 3070 Ti) if experiencing issues with open module.
    open = true;

    # Enable the Nvidia settings menu
    nvidiaSettings = true;

    # Select the driver package (stable driver recommended for 3070 Ti / Ampere cards)
    branch = "stable";
  };

  # Environment variables for Nvidia on Wayland (Niri)
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    # Low latency settings for Nvidia on Wayland / Gaming
    __GL_MaxFramesAllowed = "1";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    __GL_YIELD = "NOTHING";

    # Cache
      __GL_SHADER_DISK_CACHE_PATH = "/mnt/storage/cache/nvidia";
      __GL_SHADER_DISK_CACHE_SIZE = "107374182400"; 
      __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
  };

  # Gamemode tweaks
  programs.gamemode.settings.gpu = {
    apply_gpu_optimizations = "accept-responsibility";
    nv_powermizer_mode = 1;
  };
}
