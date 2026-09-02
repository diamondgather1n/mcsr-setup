execute if score selection chest_menu matches 1 run scoreboard players add units_left_rampart bastion.settings 1
execute if score selection chest_menu matches 2 run scoreboard players add units_lava settings 1

execute if score units_left_rampart bastion.settings matches 3.. run scoreboard players set units_left_rampart bastion.settings -1
execute if score units_lava settings matches 3.. run scoreboard players set units_lava settings 0