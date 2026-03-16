sudo tee /usr/local/bin/ventoy-mount >/dev/null <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

MP="/mnt/ventoy"
UUID="2E32-4237"

sudo mkdir -p "$MP"

# Find block device by UUID
DEV="$(blkid -U "$UUID" 2>/dev/null || true)"
if [[ -z "${DEV:-}" ]]; then
  echo "Ventoy device UUID=$UUID not found. Is the USB plugged in?"
  exit 1
fi

# If already mounted, report status
if mountpoint -q "$MP"; then
  echo "Already mounted: $MP"
  mount | grep "on $MP " || true
  exit 0
fi

# Try mount (fstab/systemd automount will also handle it)
if sudo mount "$MP" 2>/dev/null; then
  echo "Mounted via fstab: $MP"
else
  echo "Mount via fstab failed; mounting directly: $DEV -> $MP"
  sudo mount -t exfat -o rw,uid=1000,gid=1000,umask=022,iocharset=utf8,flush "$DEV" "$MP"
fi

# If mounted read-only, attempt repair + remount rw
if mount | grep "on $MP " | grep -q "(ro,"; then
  echo "Mounted read-only; attempting exFAT repair then remount rw..."
  sudo umount "$MP" || true
  sudo fsck.exfat -a "$DEV" || true
  sudo mount -t exfat -o rw,uid=1000,gid=1000,umask=022,iocharset=utf8,flush "$DEV" "$MP"
fi

echo "OK: $(mount | grep "on $MP " )"
EOF

sudo chmod +x /usr/local/bin/ventoy-mount
