# 'X Y Z' durch Koordinaten der Shulkerbox ersetzen
# 'X2 Y2 Z2' durch Koordinaten einer Zweit-Shulker ersetzen (für die Random Anordnung verwendet)
function practice:other/manage_reset

execute unless score $addrepeat randomblocks matches 1.. run function practice:other/inv_reset

scoreboard objectives add randominteger dummy

# ts in Storage speichern
execute as @s at @s in minecraft:overworld positioned -152 72 394 unless data storage minecraft:randomhotbar items[] run data modify storage minecraft:randomhotbar items[] set from block ~ ~ ~ Items
# Anzahl an Items herausfinden (Loops sparen)
execute unless score $addrepeat randomblocks matches 1.. store result score $itemcount randomblocks run data get storage minecraft:randomhotbar items[]
execute unless score $addrepeat randomblocks matches 1.. store result score $addrepeat randomblocks run data get storage minecraft:randomhotbar items[]
execute unless score $spawnedmarkers randomblocks matches 1.. run function practice:other/markerspawn

execute if score $addrepeat randomblocks matches 1.. run tag @e[type=minecraft:armor_stand,tag=randomhotbar,limit=1,sort=random] add selectedint
execute if score $addrepeat randomblocks matches 1.. as @e[tag=selectedint,limit=1,sort=random] store result storage minecraft:randomhotbar lastinteger int 1 run scoreboard players get @s randominteger
execute as @e[tag=selectedint] run kill @e[tag=selectedint,limit=1]
execute if score $addrepeat randomblocks matches 1.. run data modify storage minecraft:randomhotbar integers append from storage minecraft:randomhotbar lastinteger

scoreboard players remove $addrepeat randomblocks 1

execute if score $addrepeat randomblocks matches ..0 run function practice:other/inv_run
execute if score $addrepeat randomblocks matches ..0 run loot give @s mine -152 72 397 stick{drop_contents:true}

execute if score $addrepeat randomblocks matches 1.. run function practice:other/inv_rand

scoreboard players set timer timer 0
scoreboard players set timer settings 1