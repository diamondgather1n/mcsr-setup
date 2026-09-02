execute if score bastion settings matches 0 if score spawnpoint_random settings matches 0 run function practice:_start/_teleport_to_spawnpoint/random
execute if score bastion settings matches 0 if score spawnpoint_random settings matches 1 run function practice:_start/_teleport_to_spawnpoint/predefined
execute if score bastion settings matches 0 if score spawnpoint_random settings matches 2 run function practice:_start/_teleport_to_spawnpoint/terrain
execute if score bastion settings matches 1 run function practice:_start/_teleport_to_spawnpoint/bridge
execute if score bastion settings matches 2 run function practice:_start/_teleport_to_spawnpoint/stables
execute if score bastion settings matches 3 run function practice:_start/_teleport_to_spawnpoint/treasure
execute if score bastion settings matches 4 run function practice:_start/_teleport_to_spawnpoint/units

execute at @s run fill ~ ~ ~ ~ ~1 ~ air
execute at @s run tag @e[type=area_effect_cloud, tag=spawnpoint, sort=nearest, limit=1] add selected_spawnpoint
execute as @e[type=area_effect_cloud, tag=spawnpoint] unless entity @s[tag=selected_spawnpoint] run kill @s