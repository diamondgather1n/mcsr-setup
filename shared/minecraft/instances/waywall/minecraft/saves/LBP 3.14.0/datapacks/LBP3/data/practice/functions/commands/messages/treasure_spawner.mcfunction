execute if score treasure_spawner bastion.settings matches 0 run tellraw @a {"text":"Treasure Spawner: False"}
execute if score treasure_spawner bastion.settings matches 1 run tellraw @a {"text":"Treasure Spawner: True"}

execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2