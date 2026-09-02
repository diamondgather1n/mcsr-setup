gamerule doTileDrops false
gamerule doMobLoot false

execute if score cur_bastion_no_t practice matches 1 run function practice:_start/terrain/_clear_bastion/bridge
execute if score cur_bastion_no_t practice matches 2 run function practice:_start/terrain/_clear_bastion/stables
execute if score cur_bastion_no_t practice matches 3 run function practice:_start/terrain/_clear_bastion/treasure
execute if score cur_bastion_no_t practice matches 4 run function practice:_start/terrain/_clear_bastion/units

tag @e[type=magma_cube] add bastion_mob
execute as @e[tag=bastion_mob] at @s run tp ~ -100 ~
execute as @e[tag=bastion_mob] run data merge entity @s {Health:0.0f, DeathLootTable:"minecraft:empty", Silent:1}
kill @e[tag=bastion_mob]

kill @e[type=item]
gamerule doTileDrops true
gamerule doMobLoot true