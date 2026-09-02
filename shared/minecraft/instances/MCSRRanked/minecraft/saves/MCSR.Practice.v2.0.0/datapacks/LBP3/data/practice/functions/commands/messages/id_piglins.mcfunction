execute if score id_piglins bastion.settings matches 0 run tellraw @a {"text":"ID Piglins: False"}
execute if score id_piglins bastion.settings matches 1 run tellraw @a {"text":"ID Piglins: True"}

execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2