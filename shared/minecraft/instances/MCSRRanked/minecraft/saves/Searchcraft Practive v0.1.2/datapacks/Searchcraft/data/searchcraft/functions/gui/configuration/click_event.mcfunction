scoreboard players set event_processed gui 1

execute if score index gui matches 0 run function searchcraft:gui/configuration/save
execute if score index gui matches 2 run function searchcraft:gui/configuration/delete
execute if score index gui matches 4 run function searchcraft:gui/configuration/load_from_inventory
execute if score index gui matches 5 run function searchcraft:gui/configuration/copy_to_inventory

execute unless score index gui matches 0..2 run function searchcraft:gui/configuration/load_background
execute if score index gui matches 0..2 run function searchcraft:gui/main_menu/load

execute if score index gui matches 3 run function searchcraft:gui/configuration/ask_delete
