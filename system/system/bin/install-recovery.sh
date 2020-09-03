#!/system/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery:67108864:f2e2f7eb724f179256eb3a8288d84cfc7df428c4; then
  applypatch  \
          --patch /system/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot:67108864:acde3c18ba37cb2a919fef98cb8d96865eae89de \
          --target EMMC:/dev/block/bootdevice/by-name/recovery:67108864:f2e2f7eb724f179256eb3a8288d84cfc7df428c4 && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
