
clear @p
setblock -155 71 395 air

playsound minecraft:entity.item_frame.add_item player @a[tag=sound] ~ ~ ~ 100 0.2

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

execute at @p run fill ~ ~ ~ ~ ~1 ~ nether_portal replace air
schedule function practice:delay 2t