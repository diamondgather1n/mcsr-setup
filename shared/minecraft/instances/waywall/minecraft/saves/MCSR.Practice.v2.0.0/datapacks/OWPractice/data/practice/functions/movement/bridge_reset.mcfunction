setblock -169 87 -9 minecraft:air

kill @e[type=item]
clear @p
tp @p -169 90 36 180 0
gamemode adventure @p

playsound minecraft:entity.item_frame.add_item player @a[tag=sound] ~ ~ ~ 100 0.2

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""
