function searchcraft:gui/main_menu/load
tellraw @a {"text":"Deletion Canceled","color":"gray"}

gamemode adventure @a

execute as @a at @s run playsound minecraft:ui.button.click master @s ~ ~ ~