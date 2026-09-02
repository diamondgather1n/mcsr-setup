# Spread the AEC x blocks from the origin
execute if score spawnpoint_dist settings matches 0 run spreadplayers ~ ~ 0 100 under 100 false @s
execute if score spawnpoint_dist settings matches 1 run spreadplayers ~ ~ 0 20 under 100 false @s
execute if score spawnpoint_dist settings matches 2 positioned ^ ^ ^25 run spreadplayers ~ ~ 0 20 under 100 false @s
execute if score spawnpoint_dist settings matches 3 positioned ^ ^ ^50 run spreadplayers ~ ~ 0 20 under 100 false @s
execute if score spawnpoint_dist settings matches 4 positioned ^ ^ ^75 run spreadplayers ~ ~ 0 20 under 100 false @s
execute if score spawnpoint_dist settings matches 5 positioned ^ ^ ^100 run spreadplayers ~ ~ 0 20 under 100 false @s

# If the AEC is in a valid spawnpoint, forceload the chunk
execute at @s unless predicate practice:on_roof run forceload add ~ ~ ~ ~

# If the AEC is on the nether roof, rerun from the origin AEC until a valid spawning space is found
execute if predicate practice:on_roof at @e[type=area_effect_cloud, tag=terrain_spawnpoint_origin, limit=1] as @e[type=area_effect_cloud, tag=terrain_spawnpoint, limit=1] run function practice:_start/spawnpoint/_terrain/find_valid_location