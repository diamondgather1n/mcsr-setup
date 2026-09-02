execute as @e[type=area_effect_cloud, tag=piedar_cleaner] at @s run function practice:piedar/_remove/spawner

execute if entity @e[type=area_effect_cloud, tag=piedar_cleaner] run schedule function practice:piedar/_remove/wait_for_chunks 1t