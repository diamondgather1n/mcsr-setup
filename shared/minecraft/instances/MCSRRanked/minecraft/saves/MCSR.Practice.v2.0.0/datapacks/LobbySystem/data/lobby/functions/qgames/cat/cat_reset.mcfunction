fill 164 73 254 156 80 262 air replace minecraft:crafting_table
fill 166 80 256 166 73 260 air replace lava
fill 166 80 256 166 73 260 air replace barrier

clear @p

setblock 159 69 258 minecraft:air

execute positioned 166 73 258 unless entity @e[type=cat,distance=..2] run summon cat 166 73 258 {CatType:3,Owner:[I;1,1,1,1],Sitting:1b,Rotation:[90.0f,0.0f]}
execute positioned 166 73 258 run kill @e[type=item,distance=..5]

setblock 166 73 258 water[level=7]

setblock 162 73 257 air
schedule function lobby:qgames/cat/cat_reset_delay 0.2s
