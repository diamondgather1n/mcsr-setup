scoreboard objectives add bastion.settings dummy "\u00A7aBastionSettings"
scoreboard objectives add bastion.temp dummy "\u00A7aBastionTemp"

execute unless score bridge_left_rampart bastion.settings = bridge_left_rampart bastion.settings run scoreboard players set bridge_left_rampart bastion.settings -1
execute unless score bridge_right_rampart bastion.settings = bridge_right_rampart bastion.settings run scoreboard players set bridge_right_rampart bastion.settings -1
execute unless score units_left_rampart bastion.settings = units_left_rampart bastion.settings run scoreboard players set units_left_rampart bastion.settings -1
execute unless score treasure_center bastion.settings = treasure_center bastion.settings run scoreboard players set treasure_center bastion.settings -1
execute unless score stables_left_gap bastion.settings = stables_left_gap bastion.settings run scoreboard players set stables_left_gap bastion.settings -1
execute unless score stables_right_gap bastion.settings = stables_right_gap bastion.settings run scoreboard players set stables_right_gap bastion.settings -1
execute unless score stables_left_rampart bastion.settings = stables_left_rampart bastion.settings run scoreboard players set stables_left_rampart bastion.settings -1
execute unless score stables_middle_rampart bastion.settings = stables_middle_rampart bastion.settings run scoreboard players set stables_middle_rampart bastion.settings -1
execute unless score stables_right_rampart bastion.settings = stables_right_rampart bastion.settings run scoreboard players set stables_right_rampart bastion.settings -1
execute unless score playable_bastion bastion.settings = playable_bastion bastion.settings run scoreboard players set playable_bastion bastion.settings 0
execute unless score random_gold bastion.settings = random_gold bastion.settings run scoreboard players set random_gold bastion.settings 0
execute unless score hoglins bastion.settings = hoglins bastion.settings run scoreboard players set hoglins bastion.settings 0
execute unless score treasure_spawner bastion.settings = treasure_spawner bastion.settings run scoreboard players set treasure_spawner bastion.settings 1
execute unless score bridge_lava_fix bastion.settings = bridge_lava_fix bastion.settings run scoreboard players set bridge_lava_fix bastion.settings 0
execute unless score bastion_mobs bastion.settings = bastion_mobs bastion.settings run scoreboard players set bastion_mobs bastion.settings 1
