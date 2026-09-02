# copy self Pos to storage
data modify storage practice:playerpos Pos set from entity @s Pos

# store storage Pos into temp scoreboard
execute store result score $current.x playerpos run data get storage practice:playerpos Pos[0] 1000
execute store result score $current.y playerpos run data get storage practice:playerpos Pos[1] 1
execute store result score $current.z playerpos run data get storage practice:playerpos Pos[2] 1000