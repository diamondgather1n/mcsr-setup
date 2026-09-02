data modify storage searchcraft:recipes L append from storage searchcraft:recipes R[0]
data remove storage searchcraft:recipes R[0]

scoreboard players remove selected_recipe gui 1

execute if score selected_recipe gui matches 1.. run function searchcraft:gui/main_menu/set_recipe_selected_loop