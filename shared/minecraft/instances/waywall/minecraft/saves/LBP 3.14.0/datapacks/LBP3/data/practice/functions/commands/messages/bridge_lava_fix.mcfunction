execute if score bridge_lava_fix bastion.settings matches 0 run tellraw @a {"text":"Bridge Lava Fix: False"}
execute if score bridge_lava_fix bastion.settings matches 1 run tellraw @a {"text":"Bridge Lava Fix: True"}

execute at @a run playsound ui.cartography_table.take_result player @a ~ ~ ~ 0.8 2