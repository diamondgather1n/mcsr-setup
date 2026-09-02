execute if score bastion_mobs bastion.settings matches 1 run scoreboard players set max bastion.rng 7
execute if score bastion_mobs bastion.settings matches 1 run function bastionbuilder:internal/utils/rng/new_int

execute if score bastion_mobs bastion.settings matches 1 run execute if score out bastion.rng matches 1 run function bastionbuilder:internal/foundations/mobs/melee_piglin_always
execute if score bastion_mobs bastion.settings matches 1 run execute if score out bastion.rng matches 2..6 run function bastionbuilder:internal/foundations/mobs/melee_piglin
execute if score bastion_mobs bastion.settings matches 1 run execute if score out bastion.rng matches 7 run function bastionbuilder:internal/foundations/mobs/sword_piglin

execute if score bastion_mobs bastion.settings matches 1 run fill ~ ~ ~ ~ ~1 ~ air