scoreboard players reset event_processed gui

# 0 -> main_menu
# 1 -> configuration
execute unless score event_processed gui matches 1 if score menu gui matches 0 run function searchcraft:gui/main_menu/click_event
execute unless score event_processed gui matches 1 if score menu gui matches 1 run function searchcraft:gui/configuration/click_event

execute as @a at @s run playsound minecraft:ui.button.click master @s ~ ~ ~