scoreboard players set @p pearlCount 0
setblock -189 91 56 minecraft:redstone_block

kill @e[type=item]
kill @e[type=ender_pearl]
clear @p
give @p ender_pearl 1
tp @p -197 95 56 90 0
gamemode survival @p

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

scoreboard players set timer timer 0
scoreboard players set timer settings 1