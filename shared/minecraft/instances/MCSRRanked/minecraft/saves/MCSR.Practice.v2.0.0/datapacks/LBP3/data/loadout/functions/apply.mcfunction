clear @s

# Get selected loadout
execute if score selected loadout.settings matches 1..3 run scoreboard players operation #selected_loadout loadout.settings = selected loadout.settings
execute if score selected loadout.settings matches 4 run scoreboard players set max bastion.rng 3
execute if score selected loadout.settings matches 4 run function bastionbuilder:internal/utils/rng/new_int
execute if score selected loadout.settings matches 4 run scoreboard players operation #selected_loadout loadout.settings = out bastion.rng

execute if score #selected_loadout loadout.settings matches 1 run function loadout:apply_internal/apply_1
execute if score #selected_loadout loadout.settings matches 2 run function loadout:apply_internal/apply_2
execute if score #selected_loadout loadout.settings matches 3 run function loadout:apply_internal/apply_3