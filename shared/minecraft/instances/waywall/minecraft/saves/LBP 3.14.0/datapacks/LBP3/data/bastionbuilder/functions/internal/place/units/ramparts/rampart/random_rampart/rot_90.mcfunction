scoreboard players set max bastion.rng 3
function bastionbuilder:internal/utils/rng/new_int
scoreboard players operation units_rampart bastion.temp = out bastion.rng
execute if score units_rampart bastion.temp matches 1 run function bastionbuilder:internal/place/units/ramparts/ramparts_0/rot_90
execute if score units_rampart bastion.temp matches 2 run function bastionbuilder:internal/place/units/ramparts/ramparts_1/rot_90
execute if score units_rampart bastion.temp matches 3 run function bastionbuilder:internal/place/units/ramparts/ramparts_2/rot_90