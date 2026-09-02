scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

setblock -155 71 395 minecraft:redstone_block

clear @p
gamemode survival @p
playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 2 0.7

title @p actionbar ["",{"text":"Throw","bold":true,"color":"#77E999"},{"text":" out","color":"#F2EE8A"},{"text":" useless","bold":true,"color":"#77E999"},{"text":" items!","color":"#F2EE8A"}]

replaceitem entity @p hotbar.0 iron_axe
replaceitem entity @p hotbar.1 iron_pickaxe
replaceitem entity @p hotbar.2 iron_shovel
replaceitem entity @p hotbar.3 ender_pearl 13
replaceitem entity @p hotbar.4 flint_and_steel
replaceitem entity @p hotbar.5 oak_boat
replaceitem entity @p hotbar.6 obsidian 21
replaceitem entity @p hotbar.7 gravel 61
replaceitem entity @p hotbar.8 soul_sand 53

loot give @p loot practice:blocks/random_give
loot give @p loot practice:blocks/random_give