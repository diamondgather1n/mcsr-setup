scoreboard players set @p pearlCount 0

setblock -189 91 40 minecraft:air
fill -192 104 46 -221 90 38 air replace dirt

kill @e[type=item]
kill @e[type=ender_pearl]
clear @p
tp @p -183 90 38 90 0
gamemode adventure @p

playsound minecraft:entity.item_frame.add_item player @a[tag=sound] ~ ~ ~ 100 0.2

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""
