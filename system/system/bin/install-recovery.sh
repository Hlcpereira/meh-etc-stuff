#!/system/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery:67108864:08eea7533eb066a5a2dddcc64be85118922109e2; then
  applypatch  \
          --patch /system/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot:67108864:a60f854fce0d2ec4fbf5fe3e69f6c8abaf3935dc \
          --target EMMC:/dev/block/bootdevice/by-name/recovery:67108864:08eea7533eb066a5a2dddcc64be85118922109e2 && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
