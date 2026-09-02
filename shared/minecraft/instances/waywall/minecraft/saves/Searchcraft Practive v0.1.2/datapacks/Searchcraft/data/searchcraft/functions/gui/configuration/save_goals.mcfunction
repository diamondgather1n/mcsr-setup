execute store result score slot gui run data get storage searchcraft:recipes goals_temp[0].Slot
scoreboard players remove slot gui 9
execute if score slot gui matches 0..8 run function searchcraft:gui/configuration/save_goals_isgoal

data remove storage searchcraft:recipes goals_temp[0]
execute if data storage searchcraft:recipes goals_temp[0] run function searchcraft:gui/configuration/save_goals