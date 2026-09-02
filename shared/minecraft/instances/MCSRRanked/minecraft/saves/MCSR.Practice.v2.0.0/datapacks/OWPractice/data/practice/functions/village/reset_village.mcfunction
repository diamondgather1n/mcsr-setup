kill @e[type=item]
kill @e[type=iron_golem]
execute positioned -140 77 443 run tag @e[type=minecraft:armor_stand, distance=..2] remove isPlaced

data merge block -137 78 443 {mode:"LOAD", name:"village_layout_1", posX:1, posY:-5, posZ:1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
setblock -138 78 443 minecraft:redstone_block
setblock -138 78 443 minecraft:air

setblock -138 78 440 minecraft:air

playsound minecraft:entity.item_frame.add_item player @a[tag=sound] ~ ~ ~ 100 0.2

tag @p remove inVillage
clear @p
gamemode adventure @p
tp @p -117 77 419 0 0

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""