tellraw @s ["",{"text":"\u24d8 ","bold":true,"color":"#77E999"},{"text":"\u2022 ","bold":true,"color":"dark_gray"},{"text":"Loading...","bold":true,"color":"#77E999"}]

function lobby:refresh_tags
function lobby:disable_packs

execute positioned -146 91 45 run kill @e[type=minecraft:armor_stand,distance=..2]
execute positioned -156 90 55 run kill @e[type=minecraft:armor_stand,distance=..2]
execute positioned -156 90 55 run kill @e[type=minecraft:villager,distance=..2]

setblock -140 106 62 minecraft:redstone_block
setblock -140 106 62 minecraft:air

clear @s
execute in minecraft:overworld run tp @s -151 90 50 -180 0
spawnpoint @s -151 90 50
scoreboard players enable @a hub

scoreboard objectives setdisplay sidebar

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

title @a times 10 25 10
title @a subtitle ["",{"text":"\u2505","bold":true,"color":"dark_gray"},{"text":" Main Hub ","bold":true,"color":"#77E999"},{"text":"\u2505","bold":true,"color":"dark_gray"}]
title @a title {"text":""}

