# Remove existing spawnpoints
kill @e[type=area_effect_cloud, tag=spawnpoint]

# Standard spawnpoints
execute if score bastion_type bastion.temp matches 1 run function practice:_start/spawnpoint/bridge
execute if score bastion_type bastion.temp matches 2 run function practice:_start/spawnpoint/stables
execute if score bastion_type bastion.temp matches 3 run function practice:_start/spawnpoint/treasure
execute if score bastion_type bastion.temp matches 4 run function practice:_start/spawnpoint/units

# Terrain spawnpoint
execute if score terrain settings matches 0 if score spawnpoint_random settings matches 2 run function practice:_start/spawnpoint/terrain
execute if score terrain settings matches 0 if score spawnpoint_bridge settings matches 1 run function practice:_start/spawnpoint/terrain
execute if score terrain settings matches 0 if score spawnpoint_stables settings matches 1 run function practice:_start/spawnpoint/terrain
execute if score terrain settings matches 0 if score spawnpoint_treasure settings matches 1 run function practice:_start/spawnpoint/terrain
execute if score terrain settings matches 0 if score spawnpoint_units settings matches 1 run function practice:_start/spawnpoint/terrain