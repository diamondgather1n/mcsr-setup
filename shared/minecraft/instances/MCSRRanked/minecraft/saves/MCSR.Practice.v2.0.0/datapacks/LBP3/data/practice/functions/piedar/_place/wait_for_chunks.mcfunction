execute if score piedar settings matches 1 as @e[type=area_effect_cloud, tag=piedar, limit=1] at @s run function practice:piedar/_place/spawner
execute if score piedar settings matches 2 as @e[type=area_effect_cloud, tag=piedar, limit=1] at @s run function practice:piedar/_place/fortress

execute if entity @e[type=area_effect_cloud, tag=piedar] run schedule function practice:piedar/_place/wait_for_chunks 1t