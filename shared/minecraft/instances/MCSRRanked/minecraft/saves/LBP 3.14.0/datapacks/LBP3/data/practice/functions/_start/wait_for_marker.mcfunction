execute as @e[type=area_effect_cloud, tag=chunk_aligned, limit=1] at @s run function practice:_start/post_load

execute unless entity @e[type=area_effect_cloud, tag=chunk_aligned, limit=1] run schedule function practice:_start/wait_for_marker 1t