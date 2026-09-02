execute if score selection chest_menu matches 1 run scoreboard players add treasure_center bastion.settings 1
execute if score selection chest_menu matches 2 run scoreboard players add treasure_spawner bastion.settings 1

execute if score treasure_center bastion.settings matches 4.. run scoreboard players set treasure_center bastion.settings -1
execute if score treasure_spawner bastion.settings matches 2.. run scoreboard players set treasure_spawner bastion.settings 0