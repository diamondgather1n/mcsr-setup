execute store result score enabled gui run data get storage searchcraft:recipes recipes[{selected:1b}].enabled
scoreboard players add enabled gui 1
scoreboard players operation enabled gui %= 2 c
execute store result storage searchcraft:recipes recipes[{selected:1b}].enabled byte 1 run scoreboard players get enabled gui