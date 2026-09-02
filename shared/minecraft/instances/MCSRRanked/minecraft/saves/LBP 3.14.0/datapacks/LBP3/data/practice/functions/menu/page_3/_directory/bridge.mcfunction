execute if score selection chest_menu matches 1 run scoreboard players add bridge_left_rampart bastion.settings 1
execute if score selection chest_menu matches 2 run scoreboard players add bridge_right_rampart bastion.settings 1
execute if score selection chest_menu matches 3 run scoreboard players add bridge_lava_fix bastion.settings 1

execute if score bridge_left_rampart bastion.settings matches 2.. run scoreboard players set bridge_left_rampart bastion.settings -1
execute if score bridge_right_rampart bastion.settings matches 2.. run scoreboard players set bridge_right_rampart bastion.settings -1
execute if score bridge_lava_fix bastion.settings matches 2.. run scoreboard players set bridge_lava_fix bastion.settings 0