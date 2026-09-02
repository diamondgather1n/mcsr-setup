scoreboard players set max bastion.rng 2
function bastionbuilder:internal/utils/rng/new_int
scoreboard players operation stables_wall bastion.temp = out bastion.rng
execute if score stables_wall bastion.temp matches 1 run function bastionbuilder:internal/place/hoglin_stable/walls/side_wall_0/rot_180
execute if score stables_wall bastion.temp matches 2 run function bastionbuilder:internal/place/hoglin_stable/walls/side_wall_1/rot_180