function practice:_start/movement_detection/get_current_pos

scoreboard players reset $moved playerpos

execute unless score $current.x playerpos = $home.x playerpos run scoreboard players set $moved playerpos 1
execute as @a if score @s jumps matches 1.. run scoreboard players set $moved playerpos 1
execute unless score $current.z playerpos = $home.z playerpos run scoreboard players set $moved playerpos 1

#execute if score $moved playerpos matches 1 run tellraw @a ["Home X: ",{"score":{"name":"$home.x","objective":"playerpos"}}," ","Current X: ",{"score":{"name":"$current.x","objective":"playerpos"}}]
#execute if score $moved playerpos matches 1 run tellraw @a ["Home Z: ",{"score":{"name":"$home.z","objective":"playerpos"}}," ","Current Z: ",{"score":{"name":"$current.z","objective":"playerpos"}}]