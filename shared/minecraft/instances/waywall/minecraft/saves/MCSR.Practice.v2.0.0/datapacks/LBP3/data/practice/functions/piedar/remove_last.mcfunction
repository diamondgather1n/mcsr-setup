# Create an AEC
summon area_effect_cloud ~ ~ ~ {Tags:["piedar_cleaner"], Duration: 2147483647}

# Remove the spawner
execute as @e[type=area_effect_cloud, tag=piedar_cleaner, limit=1] run function practice:piedar/_remove/remove