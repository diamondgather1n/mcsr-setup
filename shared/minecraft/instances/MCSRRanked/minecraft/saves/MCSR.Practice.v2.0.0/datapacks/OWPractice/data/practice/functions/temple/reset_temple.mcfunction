tag @p remove inTemple

execute positioned -90 77 419 run kill @e[type=item, distance=..25]
execute positioned -90 77 419 run kill @e[type=tnt, distance=..25]

setblock -106 77 405 air

gamemode adventure @p
clear @p
playsound minecraft:entity.item_frame.add_item player @a[tag=sound] ~ ~ ~ 100 0.2
tp @p -117 77 419 -90 5

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""