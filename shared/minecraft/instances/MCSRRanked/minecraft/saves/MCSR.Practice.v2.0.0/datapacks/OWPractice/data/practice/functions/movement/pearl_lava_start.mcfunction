scoreboard players set @p inLavaPearl 1

fill -192 108 21 -238 90 34 air replace minecraft:obsidian
fill -192 95 34 -238 90 21 lava

function practice:rng
execute if score @p randomTemp matches 1 run data merge block -187 91 27 {Command:"execute if block -204 90 25 minecraft:obsidian run function practice:movement/pearl_lava_start"} 
execute if score @p randomTemp matches 1 run tellraw @a ["",{"text":"Place obsidian at ","color":"#74F56F"},{"text":"coordinates","bold":true,"color":"#74F56F"},{"text":":","color":"#74F56F"},{"text":" -204 | 90 | 25 - WEST","bold":true,"color":"#F9FF69"}]
execute if score @p randomTemp matches 2 run data merge block -187 91 27 {Command:"execute if block -214 90 31 minecraft:obsidian run function practice:movement/pearl_lava_start"}
execute if score @p randomTemp matches 2 run tellraw @a ["",{"text":"Place obsidian at ","color":"#74F56F"},{"text":"coordinates","bold":true,"color":"#74F56F"},{"text":":","color":"#74F56F"},{"text":" -214 | 90 | 31 - WEST","bold":true,"color":"#F9FF69"}]
execute if score @p randomTemp matches 3 run data merge block -187 91 27 {Command:"execute if block -225 90 26 minecraft:obsidian run function practice:movement/pearl_lava_start"}
execute if score @p randomTemp matches 3 run tellraw @a ["",{"text":"Place obsidian at ","color":"#74F56F"},{"text":"coordinates","bold":true,"color":"#74F56F"},{"text":":","color":"#74F56F"},{"text":" -225 | 90 | 26 - WEST","bold":true,"color":"#F9FF69"}]
execute if score @p randomTemp matches 4 run data merge block -187 91 27 {Command:"execute if block -233 90 29 minecraft:obsidian run function practice:movement/pearl_lava_start"}
execute if score @p randomTemp matches 4 run tellraw @a ["",{"text":"Place obsidian at ","color":"#74F56F"},{"text":"coordinates","bold":true,"color":"#74F56F"},{"text":":","color":"#74F56F"},{"text":" -233 | 90 | 29 - WEST","bold":true,"color":"#F9FF69"}]

setblock -187 91 28 minecraft:redstone_block

kill @e[type=item]
kill @e[type=ender_pearl]
clear @p
give @p ender_pearl 3
give @p obsidian 1
tp @p -193 97 27 90 0
gamemode survival @p

effect give @p fire_resistance 10000 0 false

replaceitem entity @a container.9 barrier{display:{Name:'["",{"text":"χ Back χ","italic":false,"bold":true,"color":"#ff0000"}]'}}
replaceitem entity @a container.13 barrier{display:{Name:'["",{"text":"χ Back χ","italic":false,"bold":true,"color":"#ff0000"}]'}}
replaceitem entity @a hotbar.8 barrier{display:{Name:'["",{"text":"χ Back χ","italic":false,"bold":true,"color":"#ff0000"}]'}}

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7


effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 1