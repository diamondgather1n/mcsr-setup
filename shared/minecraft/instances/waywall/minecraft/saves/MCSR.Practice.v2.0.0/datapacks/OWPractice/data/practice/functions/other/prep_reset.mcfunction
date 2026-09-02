clear @p
kill @e[type=item]
kill @e[type=silverfish]
gamemode adventure @p

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

tag @p remove inPrep

setblock -165 71 388 minecraft:air
execute in minecraft:the_end run setblock 97 41 -1 minecraft:air

function practice:other/prep_c_clear
function practice:other/prep_c_reset

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

playsound minecraft:entity.item_frame.add_item player @a[tag=sound] ~ ~ ~ 100 0.2

tp @p -155 70 388 90 0
spawnpoint @p -155 70 388