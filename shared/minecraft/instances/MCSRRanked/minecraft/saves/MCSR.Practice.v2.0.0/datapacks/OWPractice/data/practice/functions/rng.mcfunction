scoreboard players set @p randomTemp 0

execute if predicate practice:rand_50 run scoreboard players add @p randomTemp 1
execute if predicate practice:rand_50 run scoreboard players add @p randomTemp 2

scoreboard players operation @p randomTemp %= @p mod_4
scoreboard players add @p randomTemp 1
