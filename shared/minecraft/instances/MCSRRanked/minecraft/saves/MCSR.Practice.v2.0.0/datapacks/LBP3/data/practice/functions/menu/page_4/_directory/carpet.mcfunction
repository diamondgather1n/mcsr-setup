scoreboard players set bool chest_menu 1

# Increment scores
execute if score selection chest_menu matches 1 run scoreboard players add bastion_mobs bastion.settings 1
execute if score selection chest_menu matches 2 run scoreboard players add bastion_rotation practice 1
execute if score selection chest_menu matches 3 run scoreboard players add ui practice 1
execute if score selection chest_menu matches 4 run scoreboard players add logger practice 1
execute if score selection chest_menu matches 5 run scoreboard players add id_piglins bastion.settings 1
execute if score selection chest_menu matches 6 run scoreboard players add sat_reset practice 1
execute if score selection chest_menu matches 7 run scoreboard players set page chest_menu 3
execute if score selection chest_menu matches 8 run scoreboard players set page chest_menu 1

# Reset clipping scores
execute if score bastion_mobs bastion.settings matches 2.. run scoreboard players set bastion_mobs bastion.settings 0
execute if score bastion_rotation practice matches 5.. run scoreboard players set bastion_rotation practice 0
execute if score ui practice matches 2.. run scoreboard players set ui practice 0
execute if score logger practice matches 2.. run scoreboard players set logger practice 0
execute if score id_piglins bastion.settings matches 2.. run scoreboard players set id_piglins bastion.settings 0
execute if score sat_reset practice matches 2.. run scoreboard players set sat_reset practice 0