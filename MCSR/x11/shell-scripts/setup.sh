#!/usr/bin/env bash

scripts="$HOME/MCSR/x11/shell-scripts"

"$scripts/norwegian.sh"
sleep 1

dex "$HOME/Desktop/Ranked.desktop" &
ninjabrain &

discord &

helium-browser --new-window "https://dashboard.twitch.tv/popout/u/2adhd1/stream-manager/quick-actions" &
helium-browser --new-window "https://dashboard.twitch.tv/popout/u/2adhd1/stream-manager/chat" &
helium-browser --new-window "https://dashboard.twitch.tv/popout/u/2adhd1/stream-manager/activity-feed" &

main_urls=(
  "https://discord.com/channels/1286062493826940981/1286062493826940984"
  "https://twitch.tv/doogile"
  "https://youtube.com"
  "https://mcsrranked.com/stats/doogile"
  "https://ranked-collect.de/"
)
helium-browser --new-window "${main_urls[@]}" &

qpwgraph &
prismlauncher &
spotify &
flatpak run --branch=stable --arch=x86_64 --command=obs com.obsproject.Studio &

"$scripts/i3 config.sh"
i3-msg "workspace 7" >/dev/null 2>&1
