# Move the AEC to the target position
data modify storage piedar Pos set value [0.,127.,0.]
execute store result storage piedar Pos[0] double 1 run scoreboard players get piedar_x practice
execute store result storage piedar Pos[2] double 1 run scoreboard players get piedar_z practice
data modify entity @s Pos set from storage piedar Pos
data remove storage piedar Pos

# Forceload the chunk at the target position
execute at @s run forceload add ~ ~

function practice:piedar/_remove/wait_for_chunks