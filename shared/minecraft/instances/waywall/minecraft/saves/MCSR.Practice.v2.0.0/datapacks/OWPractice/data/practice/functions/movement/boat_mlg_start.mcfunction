scoreboard players set @p boatReset 1

function practice:movement/boat_mlg_rng
execute if score @p randomTemp matches 1 run data merge block -133 130 19 {mode:"LOAD", name:"clutch_2", posX:-7, posY:-48, posZ:-7}
execute if score @p randomTemp matches 2 run data merge block -133 130 19 {mode:"LOAD", name:"clutch_6", posX:-7, posY:-48, posZ:-7}
execute if score @p randomTemp matches 3 run data merge block -133 130 19 {mode:"LOAD", name:"clutch_1", posX:-7, posY:-48, posZ:-7}
execute if score @p randomTemp matches 4 run data merge block -133 130 19 {mode:"LOAD", name:"clutch_3", posX:-7, posY:-48, posZ:-7}
execute if score @p randomTemp matches 5 run data merge block -133 130 19 {mode:"LOAD", name:"clutch_2", posX:-7, posY:-48, posZ:-7}
execute if score @p randomTemp matches 6 run data merge block -133 130 19 {mode:"LOAD", name:"clutch_8", posX:-7, posY:-48, posZ:-7}
execute if score @p randomTemp matches 7 run data merge block -133 130 19 {mode:"LOAD", name:"clutch_4", posX:-7, posY:-48, posZ:-7}
execute if score @p randomTemp matches 8 run data merge block -133 130 19 {mode:"LOAD", name:"clutch_7", posX:-7, posY:-48, posZ:-7}

setblock -132 89 15 minecraft:redstone_block
setblock -132 130 19 minecraft:redstone_block
setblock -132 130 19 minecraft:air
fill -192 108 34 -238 90 21 air replace minecraft:barrier

effect clear @p
effect give @p resistance 5 4 true

clear @p

replaceitem entity @a container.9 barrier{display:{Name:'["",{"text":"χ Back χ","italic":false,"bold":true,"color":"#ff0000"}]'}}
replaceitem entity @a container.13 barrier{display:{Name:'["",{"text":"χ Back χ","italic":false,"bold":true,"color":"#ff0000"}]'}}
replaceitem entity @a hotbar.8 barrier{display:{Name:'["",{"text":"χ Back χ","italic":false,"bold":true,"color":"#ff0000"}]'}}

kill @e[type=item]
kill @e[type=boat]
gamemode survival @p
replaceitem entity @a hotbar.0 oak_boat

tp @p -137 118 15 0 90

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

scoreboard players set @p boatReset 0