scoreboard players set @p randomTemp 0

execute if predicate practice:rand_50 run scoreboard players add @p randomTemp 1
execute if predicate practice:rand_50 run scoreboard players add @p randomTemp 2
execute if predicate practice:rand_50 run scoreboard players add @p randomTemp 4

scoreboard players operation @p randomTemp %= @p mod_6
scoreboard players add @p randomTemp 1
