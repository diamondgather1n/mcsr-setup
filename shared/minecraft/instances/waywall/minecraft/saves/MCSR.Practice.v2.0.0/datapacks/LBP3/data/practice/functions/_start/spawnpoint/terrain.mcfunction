# Remove preexisting AEC's
kill @e[type=area_effect_cloud, tag=terrain_aec]

# Get a random angle between -180 and 180
scoreboard players set max bastion.rng 360
function bastionbuilder:internal/utils/rng/new_int
scoreboard players operation spawn_angle practice = out bastion.rng
scoreboard players remove spawn_angle practice 180

# Create AEC's with the random angle
summon area_effect_cloud ~ 128 ~ {Tags:["terrain_spawnpoint_origin", "terrain_aec", "spawnpoint"], Duration: 2147483647}
summon area_effect_cloud ~ 128 ~ {Tags:["terrain_spawnpoint", "terrain_aec", "spawnpoint"], Duration: 2147483647}
execute store result entity @e[type=area_effect_cloud, tag=terrain_spawnpoint_origin, limit=1] Rotation[0] float 1 run scoreboard players get spawn_angle practice

# Spread the target location AEC from the origin AEC
execute at @e[type=area_effect_cloud, tag=terrain_spawnpoint_origin, limit=1] as @e[type=area_effect_cloud, tag=terrain_spawnpoint, limit=1] run function practice:_start/spawnpoint/_terrain/find_valid_location

# Remove the origin AEC
kill @e[type=area_effect_cloud, tag=terrain_spawnpoint_origin]