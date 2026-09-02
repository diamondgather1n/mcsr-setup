execute at @p run fill ~ ~ ~ ~ ~1 ~ nether_portal replace air

setblock -150 78 414 minecraft:crafting_table

fill -148 72 416 -145 72 423 air replace minecraft:redstone_block
setblock -145 72 418 minecraft:redstone_block

gamemode survival @p
kill @e[type=minecraft:item]

schedule function practice:crafting/new_boat_delay 2t

clear @p

