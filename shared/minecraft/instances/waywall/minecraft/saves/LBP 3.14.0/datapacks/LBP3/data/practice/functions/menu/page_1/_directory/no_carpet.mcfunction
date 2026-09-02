scoreboard players set bool chest_menu 1

# Increment scores
execute if score selection chest_menu matches 1 run scoreboard players add bastion settings 1
execute if score selection chest_menu matches 2 run function practice:menu/page_1/_directory/increment_spawnpoint
execute if score selection chest_menu matches 3 run scoreboard players add spawnpoint_dist settings 1
execute if score selection chest_menu matches 4 run scoreboard players add terrain settings 1
execute if score selection chest_menu matches 5 run scoreboard players add random_gold bastion.settings 1
execute if score selection chest_menu matches 6 run scoreboard players add piedar settings 1
execute if score selection chest_menu matches 7 run scoreboard players add piedar_dist settings 1
execute if score selection chest_menu matches 8 run scoreboard players set page chest_menu 3
execute if score selection chest_menu matches 9 run scoreboard players set page chest_menu 2
execute if score selection chest_menu matches 10 run scoreboard players set page chest_menu 4

# Reset clipping scores
execute if score bastion settings matches 5.. run scoreboard players set bastion settings 0
execute if score spawnpoint_random settings matches 3.. run scoreboard players set spawnpoint_random settings 0
execute if score spawnpoint_bridge settings matches 11.. run scoreboard players set spawnpoint_bridge settings 0
execute if score spawnpoint_stables settings matches 12.. run scoreboard players set spawnpoint_stables settings 0
execute if score spawnpoint_treasure settings matches 8.. run scoreboard players set spawnpoint_treasure settings 0
execute if score spawnpoint_units settings matches 10.. run scoreboard players set spawnpoint_units settings 0
execute if score random_gold bastion.settings matches 3.. run scoreboard players set random_gold bastion.settings 0
execute if score terrain settings matches 2.. run scoreboard players set terrain settings 0
execute if score spawnpoint_dist settings matches 6.. run scoreboard players set spawnpoint_dist settings 0
execute if score piedar settings matches 3.. run scoreboard players set piedar settings 0
execute if score piedar_dist settings matches 4.. run scoreboard players set piedar_dist settings 0

# Further operations
execute if score natural_mobs settings matches 0 run gamerule doMobSpawning true
execute if score natural_mobs settings matches 1 run gamerule doMobSpawning false