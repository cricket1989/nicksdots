
#!/usr/bin/env bash
# Shows an icon depending on whether hypridle service is active

if systemctl --user is-active --quiet hypridle.service; then
  # active
  printf '{"text":"󰾪","tooltip":"hypridle: enabled\\nLeft click: toggle\\nRight click: status"}\n'
else
  # inactive
  printf '{"text":"󰾫","tooltip":"hypridle: disabled\\nLeft click: toggle\\nRight click: status"}\n'
fi
