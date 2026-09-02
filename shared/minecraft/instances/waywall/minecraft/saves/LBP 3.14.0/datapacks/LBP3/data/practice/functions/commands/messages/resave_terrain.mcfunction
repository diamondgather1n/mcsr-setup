execute if score rerun_terrain settings matches 0 if entity @e[tag=chunk_aligned] run tellraw @a {"text":"Resaved rerun terrain"}
execute if score rerun_terrain settings matches 0 unless entity @e[tag=chunk_aligned] run tellraw @a {"text":"Could not find a bastion to resave"}
execute if score rerun_terrain settings matches 1 run tellraw @a {"text":"Rerun Terrain needs to be enabled in order to resave terrain"}

execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2