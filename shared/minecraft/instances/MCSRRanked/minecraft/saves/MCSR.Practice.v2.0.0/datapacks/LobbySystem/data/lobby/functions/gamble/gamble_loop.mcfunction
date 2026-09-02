scoreboard players add @p gambleLoop 1
scoreboard players add @p itemCount 1

execute positioned -146 92 45 if score @p itemCount matches 1 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:gold_nugget",Count:1b}]}
execute positioned -146 92 45 if score @p itemCount matches 2 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:yellow_dye",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}}]}
execute positioned -146 92 45 if score @p itemCount matches 3 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:sunflower",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}}]}
execute positioned -146 92 45 if score @p itemCount matches 4 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:gold_ingot",Count:1b}]}
execute positioned -146 92 45 if score @p itemCount matches 5 run data merge entity @e[type=minecraft:armor_stand,distance=..2,limit=1] {Rotation:[45.0f],ArmorItems:[{},{},{},{id:"minecraft:nether_star",Count:1b}]}
execute if score @p itemCount matches 5 run scoreboard players set @p itemCount 0

execute positioned -146 92 45 run playsound minecraft:block.bone_block.place ambient @p

execute if score @p gambleLoop matches 0.. run schedule function lobby:gamble/gamble_loop 0.5s
execute if score @p gambleLoop matches 6.. run schedule function lobby:gamble/gamble_loop 0.3s
execute if score @p gambleLoop matches 12.. run schedule function lobby:gamble/gamble_loop 0.2s
execute if score @p gambleLoop matches 17.. run schedule function lobby:gamble/gamble_loop 0.1s
execute if score @p gambleLoop matches 28 run function lobby:gamble/gamble_start
execute if score @p gambleLoop matches 28.. run schedule clear lobby:gamble/gamble_loop
execute if score @p gambleLoop matches 28 run scoreboard players set @p gambleLoop 0