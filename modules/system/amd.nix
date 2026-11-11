{ config, pkgs, ... }:

{
  # Early Kernel Mode Setting (KMS) for smooth boot and SDDM display
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enable overdrive / overclocking, fan curve control, and power limit tuning in LACT
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  # Enable OpenGL / Vulkan / Hardware Acceleration (Mesa)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
      # OpenCL / ROCm compute runtime for local AI (Ollama, PyTorch) & Blender
      rocmPackages.clr.icd
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # Load amdgpu driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Dedicated AMD diagnostic & monitoring utility
  environment.systemPackages = with pkgs; [
    amdgpu_top
  ];

  # Environment variables for AMD on Wayland (Niri)
  environment.sessionVariables = {
    # Wayland Ozone flags
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    # Mesa / RADV Shader Cache redirected to persistent storage
    MESA_SHADER_CACHE_DIR = "/mnt/storage/cache/mesa";
    MESA_SHADER_CACHE_MAX_SIZE = "100G";

    # Force RADV (Mesa Vulkan driver for AMD)
    AMD_VULKAN_ICD = "RADV";

    # Ensure ROCm / HIP devices are detected
    ROC_ENABLE_PRE_VEGA = "0";
  };

  # Gamemode tweaks for AMD GPU
  programs.gamemode.settings.gpu = {
    apply_gpu_optimizations = "accept-responsibility";
    gpu_device = 0;
    amd_performance_level = "high";
  };
}
