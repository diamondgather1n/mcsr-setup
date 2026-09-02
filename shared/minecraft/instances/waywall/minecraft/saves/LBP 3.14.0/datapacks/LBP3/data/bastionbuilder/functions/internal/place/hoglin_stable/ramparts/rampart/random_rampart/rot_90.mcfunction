scoreboard players set max bastion.rng 3
function bastionbuilder:internal/utils/rng/new_int
scoreboard players operation stables_rampart bastion.temp = out bastion.rng
execute if score stables_rampart bastion.temp matches 1 run function bastionbuilder:internal/place/hoglin_stable/ramparts/ramparts_1/rot_90
execute if score stables_rampart bastion.temp matches 2 run function bastionbuilder:internal/place/hoglin_stable/ramparts/ramparts_2/rot_90
execute if score stables_rampart bastion.temp matches 3 run function bastionbuilder:internal/place/hoglin_stable/ramparts/ramparts_3/rot_90