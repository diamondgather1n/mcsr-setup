scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

scoreboard players operation @p buildTemp = @p buildScore

execute if score @p buildTemp <= @p buildPb run title @p actionbar {"text":"× No new PB :( ×","bold":true,"color":"#DE2A2C"}
execute if score @p buildTemp > @p buildPb run playsound minecraft:entity.player.levelup ambient @p ~ ~ ~ 0.6 1
execute if score @p buildTemp > @p buildPb run data merge block 173 72 274 {Text1:'{"text":""}',Text2:'["",{"text":"PB: ","bold":true,"color":"#FFE023"},{"score":{"name":"@p","objective":"buildTemp"},"bold":true,"color":"#FFE023"}]'}
execute if score @p buildTemp > @p buildPb run title @a actionbar ["",{"text":"NEW PB: ","color":"#FFC53C","bold":true},{"score":{"name":"@p","objective":"buildTemp"},"bold":true,"color":"#FFC53C"}]

execute if score @p buildScore > @p buildPb run scoreboard players operation @p buildPb = @p buildScore

execute if score @p buildSound matches 3 run playsound minecraft:entity.illusioner.prepare_mirror ambient @p ~ ~ ~ 1 2

scoreboard players set @p buildScore 0
scoreboard players set @p buildCount 0
scoreboard players set @p buildRunning 0
scoreboard players set @p buildTemp 0
scoreboard players set @p buildSound 0

clear @p
gamemode adventure @p
fill 151 75 291 159 75 283 air
scoreboard players set @p inBuild 0
setblock 148 76 297 minecraft:air
fill 151 75 291 159 75 283 air
fill 146 77 291 146 85 283 air
setblock 145 76 294 minecraft:air
setblock 145 76 297 minecraft:air

tp @p 177 72 272 90 0