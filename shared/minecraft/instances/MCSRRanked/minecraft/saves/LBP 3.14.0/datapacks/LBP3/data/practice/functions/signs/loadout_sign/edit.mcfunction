scoreboard players set editing_loadout practice 1
function practice:_start/silent_gamemode/creative
function loadout:apply
title @s actionbar {"text":"Editing Loadout","color":"#F8EE16"}
playsound ui.button.click block @s ~ ~ ~ 0.35 1.05
function practice:signs/loadout_sign/update