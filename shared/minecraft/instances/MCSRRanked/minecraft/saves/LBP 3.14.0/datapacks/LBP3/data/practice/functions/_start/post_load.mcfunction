# Remove all forceloaded chunks
execute in the_nether run forceload remove all

# Load the chunks around the chunk-aligned AEC
forceload add ~-80 ~-80 ~80 ~80

# If terrain is disabled, clear the last generated bastion at [0, 0]
execute if score terrain settings matches 1 positioned 0 128 0 run function practice:_start/terrain/clear_bastion

# Get the bastion type
execute if score bastion settings matches 0 run scoreboard players set max bastion.rng 4
execute if score bastion settings matches 0 run function bastionbuilder:internal/utils/rng/new_int
execute if score bastion settings matches 0 run scoreboard players operation bastion_type bastion.temp = out bastion.rng
execute if score bastion settings matches 1.. run scoreboard players operation bastion_type bastion.temp = bastion settings

# Get the bastion rotation
function practice:_start/get_rotation

# If terrain is disabled, generate the floor for the bastion
execute if score terrain settings matches 1 positioned 0 127 0 run function practice:_start/terrain/place_floor

# Remove lava from the terrain
execute if score terrain settings matches 0 run function practice:_start/terrain/remove_lava

# If rerun terrain is disabled, save the terrain for later use
execute if score rerun_terrain settings matches 1 run function practice:_start/terrain/save

# Generate the bastion
execute if score terrain settings matches 0 positioned ~ 32 ~ run function bastionbuilder:generate
execute if score terrain settings matches 1 positioned 0 128 0 run function bastionbuilder:generate

# If terrain is disabled, save the current no-terrain bastion info
execute if score terrain settings matches 1 run scoreboard players operation cur_bastion_no_t practice = bastion_type bastion.temp
execute if score terrain settings matches 1 run scoreboard players operation cur_rotation_no_t practice = bastion_rotation bastion.temp

# Place spawnpoint AEC's
execute positioned ~0.5 ~0.5 ~0.5 run function practice:_start/place_spawnpoints

# If lava flooding is enabled, place lava in the bastion
execute if score units_lava settings matches 0..1 run function practice:_start/terrain/flood_bastion

# Teleport to the selected spawnpoint AEC
execute as @a at @s run function practice:_start/teleport_to_spawnpoint

# If terrain is enabled and piedar is enabled, place the piedar structure
execute if score terrain settings matches 0 if score piedar settings matches 1.. run function practice:piedar/place

# If rerun terrain is enabled, save the bastion and current terrain for later use
execute if score rerun_terrain settings matches 0 as @e[type=area_effect_cloud, tag=!hub_entity, tag=!bastion_chest] at @s run tp ~ ~100 ~
execute if score rerun_terrain settings matches 0 run function practice:_start/terrain/save
execute if score rerun_terrain settings matches 0 as @e[type=area_effect_cloud, tag=!hub_entity, tag=!bastion_chest] at @s run tp ~ ~-100 ~

# Reset movement detection
execute as @a run function practice:_start/movement_detection/set_home
scoreboard players reset @a jumps

# ID piglins if the option is enabled
execute if score id_piglins bastion.settings matches 1.. run function practice:_start/id_piglins

execute if score has_carpet practice matches 0 run function practice:_start/wait_for_movement/standard
execute if score has_carpet practice matches 1 run function practice:_start/wait_for_movement/warp