# Remove the previous spawner
function practice:piedar/remove_last

# Get the players current x and z position
execute store result score piedar_x practice run data get entity @s Pos[0]
execute store result score piedar_z practice run data get entity @s Pos[2]

# Get the target position
function practice:piedar/_place/get_coordinates
scoreboard players operation piedar_x practice += piedar_dx practice
scoreboard players operation piedar_z practice += piedar_dz practice

# Create an AEC
summon area_effect_cloud ~ ~ ~ {Tags:["piedar"], Duration: 2147483647}

# Generate the spawner
execute as @e[type=area_effect_cloud, tag=piedar] run function practice:piedar/_place/place