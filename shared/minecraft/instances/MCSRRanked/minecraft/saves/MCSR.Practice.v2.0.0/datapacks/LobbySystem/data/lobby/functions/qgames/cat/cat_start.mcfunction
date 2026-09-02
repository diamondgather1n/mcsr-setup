fill 164 73 254 156 80 262 air replace minecraft:crafting_table
fill 166 80 256 166 73 260 air replace lava
fill 166 80 256 166 73 260 air replace barrier

setblock 159 69 258 minecraft:redstone_block

execute if score @p catType matches 1 run setblock 166 80 260 lava
execute if score @p catType matches 1 run setblock 166 80 259 barrier
execute if score @p catType matches 2 run setblock 166 80 258 lava
execute if score @p catType matches 2 run setblock 166 80 257 barrier
execute if score @p catType matches 3 run setblock 166 79 257 lava
execute if score @p catType matches 3 run setblock 166 78 257 barrier
execute if score @p catType matches 4 run setblock 166 78 258 lava
execute if score @p catType matches 4 run setblock 166 78 259 barrier
execute if score @p catType matches 5 run setblock 166 78 259 lava
execute if score @p catType matches 5 run setblock 166 78 260 barrier
execute if score @p catType matches 6 run setblock 166 78 260 lava
execute if score @p catType matches 6 run setblock 166 77 260 barrier
execute if score @p catType matches 7 run setblock 166 77 260 lava
execute if score @p catType matches 7 run setblock 166 76 260 barrier
execute if score @p catType matches 8 run setblock 166 76 260 lava
execute if score @p catType matches 8 run setblock 166 76 259 barrier
execute if score @p catType matches 9 run setblock 166 76 259 lava
execute if score @p catType matches 9 run setblock 166 76 258 barrier 
execute if score @p catType matches 9 run setblock 166 76 260 barrier
execute if score @p catType matches 10 run setblock 166 76 258 lava
execute if score @p catType matches 10 run setblock 166 75 258 barrier 

schedule function lobby:qgames/cat/cat_delay 2t

effect give @p minecraft:instant_health 1 10
effect give @p minecraft:saturation 1 2

gamemode survival @p
clear @p
execute if score @p catMode matches 1 run replaceitem entity @p hotbar.0 oak_log 2
execute if score @p catMode matches 2 run replaceitem entity @p hotbar.0 oak_log 9
data merge block 163 73 257 {LootTable:"lobby:bt"}

execute positioned 166 73 258 run kill @e[type=item,distance=..15]
execute positioned 166 73 258 unless entity @e[type=cat,distance=..2] run summon cat 166 73 258 {CatType:3,Owner:[I;1,1,1,1],Sitting:1b,Rotation:[90.0f,0.0f]}

