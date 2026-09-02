execute if score piedar_dist settings matches 1 run scoreboard players set max bastion.rng 256
execute if score piedar_dist settings matches 2 run scoreboard players set max bastion.rng 384
execute if score piedar_dist settings matches 3 run scoreboard players set max bastion.rng 512

function bastionbuilder:internal/utils/rng/new_int
scoreboard players operation piedar_dz practice = out bastion.rng

execute if score piedar_dist settings matches 0 run scoreboard players set piedar_dz practice 65
execute if score piedar_dist settings matches 1 run scoreboard players remove piedar_dz practice 128
execute if score piedar_dist settings matches 2 run scoreboard players remove piedar_dz practice 192
execute if score piedar_dist settings matches 3 run scoreboard players remove piedar_dz practice 256