scoreboard players set @p inRp 0
scoreboard players set @a resetCheck 0

tag @a remove inRp

setblock -151 93 442 minecraft:air

kill @e[type=item]
gamemode adventure @p
clear @p
playsound minecraft:entity.item_frame.add_item player @a[tag=sound] ~ ~ ~ 100 0.2
tp @p -117 77 419 90 0

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""