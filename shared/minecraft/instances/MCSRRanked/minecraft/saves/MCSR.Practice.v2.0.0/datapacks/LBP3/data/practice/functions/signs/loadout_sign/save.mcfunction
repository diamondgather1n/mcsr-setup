scoreboard players set editing_loadout practice 0
function practice:_start/silent_gamemode/adventure
function loadout:store
clear @s
title @s actionbar {"text":"Saved Loadout","color":"#35FF21"}
playsound ui.button.click block @s ~ ~ ~ 0.35 1
function practice:signs/loadout_sign/update