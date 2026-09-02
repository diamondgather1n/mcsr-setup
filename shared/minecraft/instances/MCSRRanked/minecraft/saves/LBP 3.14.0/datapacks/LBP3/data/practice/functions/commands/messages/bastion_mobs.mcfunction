execute if score bastion_mobs bastion.settings matches 0 run tellraw @a {"text":"Bastion Mobs: False"}
execute if score bastion_mobs bastion.settings matches 1 run tellraw @a {"text":"Bastion Mobs: True"}

execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2