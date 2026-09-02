scoreboard players set @p pearlCount 0

setblock -189 91 40 minecraft:redstone_block
fill -192 104 46 -221 90 38 air replace dirt

kill @e[type=item]
kill @e[type=ender_pearl]
clear @p
give @p ender_pearl 1
replaceitem entity @p hotbar.8 minecraft:dirt 32
tp @p -193 93 42 90 0
gamemode survival @p

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 1