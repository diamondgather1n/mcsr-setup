scoreboard players operation selected_recipe gui = page gui
scoreboard players operation selected_recipe gui *= 7 c
scoreboard players operation temp_index gui = index gui
scoreboard players operation temp_index gui %= 7 c
scoreboard players operation selected_recipe gui += temp_index gui
scoreboard players reset temp_index gui

data remove storage searchcraft:recipes recipes[].selected

data modify storage searchcraft:recipes R set from storage searchcraft:recipes recipes
data modify storage searchcraft:recipes L set value []

execute if score selected_recipe gui matches 1.. run function searchcraft:gui/main_menu/set_recipe_selected_loop

data modify storage searchcraft:recipes R[0].selected set value 1b
data modify storage searchcraft:recipes recipes set from storage searchcraft:recipes L
data modify storage searchcraft:recipes recipes append from storage searchcraft:recipes R[]