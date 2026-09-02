scoreboard players set mod randomTemp 35
clear @p
gamemode creative @p
execute if score @p buildRunning matches 1 run scoreboard players add @p buildScore 1
execute if score @p buildRunning matches 1 run title @a times 10 30 10
execute if score @p buildRunning matches 1 run title @a subtitle ["",{"text":"Score: ","bold":true,"color":"#FFC53C"},{"score":{"name":"@p","objective":"buildScore"},"bold":true,"color":"#FFC53C"}]
execute if score @p buildRunning matches 1 run title @a title {"text":""}

setblock 146 76 294 minecraft:air
setblock 145 87 295 minecraft:redstone_block
setblock 145 87 295 minecraft:air
fill 146 85 291 146 77 283 air
scoreboard players set @p buildCount 0
fill 151 75 291 159 75 283 air
execute at @a[tag=sound] run playsound minecraft:block.note_block.bell ambient @a[tag=sound] ~ ~ ~ 0.5 0.2
execute at @a[tag=sound] run playsound minecraft:block.stone.break ambient @a[tag=sound] ~ ~ ~ 2 1.1
particle minecraft:block gold_block 155 75.5 287 3 0 3 1 200

execute if score @p inBuild matches 1 run schedule function lobby:qgames/build/build_loop 0.5s