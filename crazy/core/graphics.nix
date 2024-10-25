{ pkgs, ... }:
{
  hardware.asahi = {
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "overlay";
  };
}
