function searchcraft:gui/clear_by_index

execute if score index gui matches -1.. run function searchcraft:gui/click_event

scoreboard players reset index gui