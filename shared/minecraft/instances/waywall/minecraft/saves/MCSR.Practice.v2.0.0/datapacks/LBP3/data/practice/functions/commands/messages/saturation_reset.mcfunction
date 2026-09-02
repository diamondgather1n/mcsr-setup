execute if score has_carpet practice matches 1 if score sat_reset practice matches 0 run tellraw @a {"text":"Saturation Resetting: False"}
execute if score has_carpet practice matches 1 if score sat_reset practice matches 1 run tellraw @a {"text":"Saturation Resetting: True"}

execute if score has_carpet practice matches 0 run tellraw @a {"text":"Saturation resetting requires Carpet Mod"}
execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2