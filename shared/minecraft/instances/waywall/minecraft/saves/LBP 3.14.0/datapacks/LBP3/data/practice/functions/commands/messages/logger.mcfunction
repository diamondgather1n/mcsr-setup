execute if score logger practice matches 0 run tellraw @a {"text":"Logger: False"}
execute if score logger practice matches 1 run tellraw @a {"text":"Logger: True"}

execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2