gamerule fallDamage false

effect give @p minecraft:instant_health 1 10
effect give @p minecraft:saturation 1 2

setblock 167 73 286 minecraft:air

fill 176 72 285 172 79 290 air replace minecraft:yellow_concrete

scoreboard players set mod randomTemp 20

function lobby:gamble/gamble_rng
execute if score r randomTemp matches 1 run setblock 172 74 287 minecraft:yellow_concrete
execute if score r randomTemp matches 2 run setblock 173 74 287 minecraft:yellow_concrete
execute if score r randomTemp matches 3 run setblock 174 74 287 minecraft:yellow_concrete
execute if score r randomTemp matches 4 run setblock 175 74 287 minecraft:yellow_concrete
execute if score r randomTemp matches 5 run setblock 176 74 287 minecraft:yellow_concrete
execute if score r randomTemp matches 6 run setblock 172 74 288 minecraft:yellow_concrete
execute if score r randomTemp matches 7 run setblock 173 74 288 minecraft:yellow_concrete
execute if score r randomTemp matches 8 run setblock 174 74 288 minecraft:yellow_concrete
execute if score r randomTemp matches 9 run setblock 172 73 288 minecraft:yellow_concrete
execute if score r randomTemp matches 10 run setblock 173 73 288 minecraft:yellow_concrete
execute if score r randomTemp matches 11 run setblock 174 73 288 minecraft:yellow_concrete
execute if score r randomTemp matches 12 run setblock 175 73 288 minecraft:yellow_concrete
execute if score r randomTemp matches 13 run setblock 176 73 288 minecraft:yellow_concrete
execute if score r randomTemp matches 14 run setblock 173 73 289 minecraft:yellow_concrete
execute if score r randomTemp matches 15 run setblock 174 73 289 minecraft:yellow_concrete
execute if score r randomTemp matches 16 run setblock 175 73 289 minecraft:yellow_concrete
execute if score r randomTemp matches 17 run setblock 175 74 288 minecraft:yellow_concrete
execute if score r randomTemp matches 18 run setblock 176 74 288 minecraft:yellow_concrete
execute if score r randomTemp matches 19 run setblock 176 72 289 minecraft:yellow_concrete
execute if score r randomTemp matches 20 run setblock 172 72 289 minecraft:yellow_concrete

tp @p 174.5 74.00 283.2 0 15

setblock 167 73 286 redstone_block