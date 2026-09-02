execute if score ui practice matches 0 run tellraw @a {"text":"UI: False"}
execute if score ui practice matches 1 run tellraw @a {"text":"UI: True"}

execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2