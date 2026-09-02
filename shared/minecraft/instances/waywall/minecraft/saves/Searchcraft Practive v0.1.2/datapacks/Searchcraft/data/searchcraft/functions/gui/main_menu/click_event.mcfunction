scoreboard players set event_processed gui 1

execute if score index gui matches 0..13 run function searchcraft:gui/main_menu/set_recipe_selected

execute if score index gui matches 0..6 run function searchcraft:gui/main_menu/toggle_enabled

execute if score index gui matches 23 run function searchcraft:gui/main_menu/disable_everything
execute if score index gui matches 24 run function searchcraft:gui/main_menu/enable_everything

execute if score index gui matches 25 if score page gui matches 1.. run scoreboard players remove page gui 1
execute if score index gui matches 26 if score page gui matches ..8 run scoreboard players add page gui 1

execute unless score index gui matches 7..13 run function searchcraft:gui/main_menu/load
execute if score index gui matches 7..13 run function searchcraft:gui/configuration/load
