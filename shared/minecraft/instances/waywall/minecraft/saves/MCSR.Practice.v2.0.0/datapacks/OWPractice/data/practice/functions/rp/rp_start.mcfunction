scoreboard players set @p inRp 1
scoreboard players set @a resetCheck 0
kill @e[type=item]
tag @p add inRp

fill -155 104 472 -164 94 462 air replace water
fill -155 107 445 -182 94 472 minecraft:stone_brick_slab[type=top,waterlogged=false] replace minecraft:stone_brick_slab
fill -182 106 472 -155 79 445 air replace water

scoreboard players set mod randomTemp 10
function practice:rp/rp_rng
execute if score r randomTemp matches 1 run data merge block -153 93 443 {mode:"LOAD", name:"rp_1", posX:-30, posY:-15, posZ:1}
execute if score r randomTemp matches 2 run data merge block -153 93 443 {mode:"LOAD", name:"rp_2", posX:-30, posY:-15, posZ:1}
execute if score r randomTemp matches 3 run data merge block -153 93 443 {mode:"LOAD", name:"rp_3", posX:-30, posY:-15, posZ:1}
execute if score r randomTemp matches 4 run data merge block -153 93 443 {mode:"LOAD", name:"rp_4", posX:-30, posY:-15, posZ:1}
execute if score r randomTemp matches 5 run data merge block -153 93 443 {mode:"LOAD", name:"rp_5", posX:-30, posY:-15, posZ:1}
execute if score r randomTemp matches 6 run data merge block -153 93 443 {mode:"LOAD", name:"rp_6", posX:-30, posY:-15, posZ:1}
execute if score r randomTemp matches 7 run data merge block -153 93 443 {mode:"LOAD", name:"rp_7", posX:-30, posY:-15, posZ:1}
execute if score r randomTemp matches 8 run data merge block -153 93 443 {mode:"LOAD", name:"rp_8", posX:-30, posY:-15, posZ:1}
execute if score r randomTemp matches 9 run data merge block -153 93 443 {mode:"LOAD", name:"rp_9", posX:-30, posY:-15, posZ:1}
execute if score r randomTemp matches 10 run data merge block -153 93 443 {mode:"LOAD", name:"rp_10", posX:-30, posY:-15, posZ:1}

setblock -153 93 442 minecraft:redstone_block
setblock -153 93 442 minecraft:air

execute if score r randomTemp matches 1 run data merge block -160 91 448 {LootTable:"practice:rp_bt"}
execute if score r randomTemp matches 2 run data merge block -180 92 457 {LootTable:"practice:rp_bt"}
execute if score r randomTemp matches 3 run data merge block -160 92 447 {LootTable:"practice:rp_bt"}
execute if score r randomTemp matches 4 run data merge block -174 88 469 {LootTable:"practice:rp_bt"}
execute if score r randomTemp matches 5 run data merge block -180 91 447 {LootTable:"practice:rp_bt"}
execute if score r randomTemp matches 6 run data merge block -175 91 469 {LootTable:"practice:rp_bt"}
execute if score r randomTemp matches 7 run data merge block -159 91 446 {LootTable:"practice:rp_bt"}
execute if score r randomTemp matches 8 run data merge block -159 91 447 {LootTable:"practice:rp_bt"}
execute if score r randomTemp matches 9 run data merge block -157 91 448 {LootTable:"practice:rp_bt"}
execute if score r randomTemp matches 10 run data merge block -160 90 446 {LootTable:"practice:rp_bt"}

kill @e[type=item]
gamemode survival @a
clear @a

replaceitem entity @a container.9 barrier{display:{Name:'["",{"text":"χ Reset χ","italic":false,"bold":true,"color":"#ff0000"}]'}}
replaceitem entity @a container.13 barrier{display:{Name:'["",{"text":"χ Reset χ","italic":false,"bold":true,"color":"#ff0000"}]'}}

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 1

schedule function practice:rp/rp_delay 2t
