scoreboard players set max bastion.rng 4
function bastionbuilder:internal/utils/rng/new_int
scoreboard players operation treasure_center bastion.temp = out bastion.rng
execute if score treasure_center bastion.temp matches 1 run function bastionbuilder:internal/place/treasure/bases/centers/center_0/rot_270
execute if score treasure_center bastion.temp matches 2 run function bastionbuilder:internal/place/treasure/bases/centers/center_1/rot_270
execute if score treasure_center bastion.temp matches 3 run function bastionbuilder:internal/place/treasure/bases/centers/center_2/rot_270
execute if score treasure_center bastion.temp matches 4 run function bastionbuilder:internal/place/treasure/bases/centers/center_3/rot_270