execute if entity @e[tag=selected_spawnpoint] run tellraw @a {"text":"Moved the current rerun spawnpoint"}
execute unless entity @e[tag=selected_spawnpoint] run tellraw @a {"text":"Could not find a spawnpoint to move"}

execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2