execute if score spawnpoint_treasure settings matches 0 run function practice:_start/_teleport_to_spawnpoint/random
execute if score spawnpoint_treasure settings matches 1 run function practice:_start/_teleport_to_spawnpoint/terrain
execute if score spawnpoint_treasure settings matches 2 run tp @e[type=area_effect_cloud, tag=lava_basin, limit=1]
execute if score spawnpoint_treasure settings matches 3 run tp @e[type=area_effect_cloud, tag=ledge, limit=1]
execute if score spawnpoint_treasure settings matches 4 run tp @e[type=area_effect_cloud, tag=top_lower, limit=1]
execute if score spawnpoint_treasure settings matches 5 run tp @e[type=area_effect_cloud, tag=lower_treasure, limit=1]
execute if score spawnpoint_treasure settings matches 6 run tp @e[type=area_effect_cloud, tag=left_rampart_top, limit=1]
execute if score spawnpoint_treasure settings matches 7 run tp @e[type=area_effect_cloud, tag=right_rampart_top, limit=1]