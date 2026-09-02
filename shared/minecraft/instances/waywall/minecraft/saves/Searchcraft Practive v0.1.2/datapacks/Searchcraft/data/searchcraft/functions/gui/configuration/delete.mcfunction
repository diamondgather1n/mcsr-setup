data remove storage searchcraft:recipes recipes[{selected:1b}]
tellraw @a {"text":"Recipe Deleted","color":"red"}

gamemode adventure @a
execute as @a at @s run playsound minecraft:ui.button.click master @s ~ ~ ~