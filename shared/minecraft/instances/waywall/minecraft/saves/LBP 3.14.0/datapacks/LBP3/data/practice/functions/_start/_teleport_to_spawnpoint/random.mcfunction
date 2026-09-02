tp @e[type=area_effect_cloud, tag=spawnpoint, limit=1, sort=random]
execute at @s unless block ~ ~1 ~ #practice:air run kill @e[type=area_effect_cloud, tag=spawnpoint, limit=1, sort=nearest]
execute at @s unless block ~ ~1 ~ #practice:air run function practice:_start/_teleport_to_spawnpoint/random