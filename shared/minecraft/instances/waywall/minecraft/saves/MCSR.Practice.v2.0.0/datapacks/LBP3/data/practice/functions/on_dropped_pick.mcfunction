scoreboard players reset @a dropped_net_pick
scoreboard players reset @a dropped_dia_pick
scoreboard players reset @a dropped_iro_pick
scoreboard players reset @a dropped_gol_pick
scoreboard players reset @a dropped_sto_pick
scoreboard players reset @a dropped_woo_pick

# If player is not standing, stop the current run
execute unless predicate practice:sneaking run function practice:stop

# If the player is sneaking, restart the current run
execute if predicate practice:sneaking run function practice:rerun
