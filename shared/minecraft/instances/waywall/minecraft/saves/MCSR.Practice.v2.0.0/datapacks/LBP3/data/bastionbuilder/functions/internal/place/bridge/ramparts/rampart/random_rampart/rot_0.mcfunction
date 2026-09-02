scoreboard players set max bastion.rng 2
function bastionbuilder:internal/utils/rng/new_int
scoreboard players operation bridge_rampart bastion.temp = out bastion.rng
execute if score bridge_rampart bastion.temp matches 1 run function bastionbuilder:internal/place/bridge/ramparts/rampart_0/rot_0
execute if score bridge_rampart bastion.temp matches 2 run function bastionbuilder:internal/place/bridge/ramparts/rampart_1/rot_0