execute if score selection chest_menu matches 1 run scoreboard players add stables_left_gap bastion.settings 1
execute if score selection chest_menu matches 2 run scoreboard players add stables_right_gap bastion.settings 1
execute if score selection chest_menu matches 3 run scoreboard players add stables_left_rampart bastion.settings 1
execute if score selection chest_menu matches 4 run scoreboard players add stables_middle_rampart bastion.settings 1
execute if score selection chest_menu matches 5 run scoreboard players add stables_right_rampart bastion.settings 1

execute if score stables_left_gap bastion.settings matches 2.. run scoreboard players set stables_left_gap bastion.settings -1
execute if score stables_right_gap bastion.settings matches 2.. run scoreboard players set stables_right_gap bastion.settings -1
execute if score stables_left_rampart bastion.settings matches 3.. run scoreboard players set stables_left_rampart bastion.settings -1
execute if score stables_middle_rampart bastion.settings matches 3.. run scoreboard players set stables_middle_rampart bastion.settings -1
execute if score stables_right_rampart bastion.settings matches 3.. run scoreboard players set stables_right_rampart bastion.settings -1