execute if score bastion_rotation practice matches 0 run scoreboard players set max bastion.rng 4
execute if score bastion_rotation practice matches 0 run function bastionbuilder:internal/utils/rng/new_int
execute if score bastion_rotation practice matches 0 run scoreboard players operation bastion_rotation bastion.temp = out bastion.rng

execute if score bastion_rotation practice matches 1.. run scoreboard players operation bastion_rotation bastion.temp = bastion_rotation practice