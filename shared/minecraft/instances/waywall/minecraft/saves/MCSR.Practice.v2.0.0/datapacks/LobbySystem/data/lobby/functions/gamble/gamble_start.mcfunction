scoreboard players remove @p coins 10

scoreboard players set mod randomTemp 30
function lobby:gamble/gamble_rng

execute if score r randomTemp matches 0..7 run scoreboard players add @p coins 1
execute if score r randomTemp matches 8..15 run scoreboard players add @p coins 5
execute if score r randomTemp matches 16..24 run scoreboard players add @p coins 10
execute if score r randomTemp matches 25..29 run scoreboard players add @p coins 20 
execute if score r randomTemp matches 30 run scoreboard players add @p coins 100 

title @a times 20 30 20

execute if score r randomTemp matches 0..7 run title @a actionbar ["",{"text":"You won ","color":"#FFCC18"},{"text":"1","bold":true,"color":"#FFCC18"},{"text":" coin!","color":"#FFCC18"}]
execute positioned -146 92 45 if score r randomTemp matches 0..7 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:gold_nugget",Count:1b}]}
execute if score r randomTemp matches 8..15 run title @a actionbar ["",{"text":"You won ","color":"#FFCC18"},{"text":"5","bold":true,"color":"#FFCC18"},{"text":" coins!","color":"#FFCC18"}]
execute positioned -146 92 45 if score r randomTemp matches 8..15 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:yellow_dye",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}}]}
execute if score r randomTemp matches 16..24 run title @a actionbar ["",{"text":"You won ","color":"#FFCC18"},{"text":"10","bold":true,"color":"#FFCC18"},{"text":" coins!","color":"#FFCC18"}]
execute positioned -146 92 45 if score r randomTemp matches 16..24 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:sunflower",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}}]}
execute if score r randomTemp matches 25..29 run title @a actionbar ["",{"text":"You won ","color":"#FFCC18"},{"text":"20","bold":true,"color":"#FFCC18"},{"text":" coins!","color":"#FFCC18"}]
execute positioned -146 92 45 if score r randomTemp matches 25..29 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:gold_ingot",Count:1b}]}
execute if score r randomTemp matches 30 run title @a actionbar ["",{"text":"JACKPOT! - ","color":"#FFCC18"},{"text":"100","bold":true,"color":"#FFCC18"},{"text":" coins!","color":"#FFCC18"}]
execute positioned -146 92 45 if score r randomTemp matches 30 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:nether_star",Count:1b}]}
execute if score r randomTemp matches 30 run playsound minecraft:entity.player.levelup ambient @p ~ ~ ~ 0.6 0.5

execute positioned -146 92 45 run playsound minecraft:block.conduit.deactivate ambient @p ~ ~ ~ 1 1.4
particle minecraft:totem_of_undying -145.5 92.8 45.5 1.2 1.2 1.2 0.1 30 force
scoreboard players set @p gambleRunning 0
