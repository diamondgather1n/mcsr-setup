execute if score bastion_rotation practice matches 0 run tellraw @a {"text":"Bastion Rotation: Random"}
execute if score bastion_rotation practice matches 1 run tellraw @a {"text":"Bastion Rotation: 0 Degrees"}
execute if score bastion_rotation practice matches 2 run tellraw @a {"text":"Bastion Rotation: 90 Degrees"}
execute if score bastion_rotation practice matches 3 run tellraw @a {"text":"Bastion Rotation: 180 Degrees"}
execute if score bastion_rotation practice matches 4 run tellraw @a {"text":"Bastion Rotation: 270 Degrees"}

execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2