sudo tee /usr/local/bin/ventoy-eject >/dev/null <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

MP="/mnt/ventoy"
UUID="2E32-4237"

DEV="$(blkid -U "$UUID" 2>/dev/null || true)"
if [[ -z "${DEV:-}" ]]; then
  echo "Ventoy device not found (UUID=$UUID)."
  exit 1
fi

echo "Syncing..."
sync

if mountpoint -q "$MP"; then
  echo "Unmounting $MP..."
  sudo umount "$MP"
fi

echo "Powering off device (safe remove)..."
# Works even if /dev/sda changes
sudo udisksctl power-off -b "$DEV" >/dev/null || true

echo "Safe to unplug."
EOF

sudo chmod +x /usr/local/bin/ventoy-eject
