scoreboard players set @p inLavaPearl 0
setblock -187 91 28 minecraft:air
fill -192 95 34 -238 90 21 air

effect clear @p
kill @e[type=item]
kill @e[type=ender_pearl]
clear @p
tp @p -183 90 38 90 0
gamemode creative @p
schedule function practice:movement/pearl_lava_delay 2t

playsound minecraft:entity.item_frame.add_item player @a[tag=sound] ~ ~ ~ 100 0.2

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""
