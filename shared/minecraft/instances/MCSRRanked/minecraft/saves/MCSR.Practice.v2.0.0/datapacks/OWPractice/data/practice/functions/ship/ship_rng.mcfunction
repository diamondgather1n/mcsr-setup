scoreboard players set @p randomTemp 0

execute if predicate practice:rand_50 run scoreboard players add @p randomTemp 1
execute if predicate practice:rand_50 run scoreboard players add @p randomTemp 2

# Modulo 3 will keep the number between 0 and 2
scoreboard players operation @p randomTemp %= @p mod_3

execute if score @p randomTemp matches 0 run function practice:ship/ship_rng