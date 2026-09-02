scoreboard players add @p buildCount 1

execute if score @p inBuild matches 1 if score @p buildCount matches 1 run setblock 146 81 289 minecraft:red_concrete
execute if score @p inBuild matches 1 if score @p buildCount matches 1 run function lobby:gamble/gamble_rng
execute if score @p inBuild matches 1 if score @p buildCount matches 2 run setblock 146 81 287 minecraft:yellow_concrete
execute if score @p inBuild matches 1 if score @p buildCount matches 3 run setblock 146 81 285 minecraft:lime_concrete
execute if score @p inBuild matches 1 if score @p buildCount matches 4 run function lobby:qgames/build/build_start

execute if score @p inBuild matches 1 if score @p buildCount matches 1..3 at @a[tag=sound] run playsound minecraft:block.comparator.click ambient @p ~ ~ ~ 1 0.9
execute if score @p inBuild matches 1 if score @p buildCount matches 1..4 run schedule function lobby:qgames/build/build_loop 0.75s