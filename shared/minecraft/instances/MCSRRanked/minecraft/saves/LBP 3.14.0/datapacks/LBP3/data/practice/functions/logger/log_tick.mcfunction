execute as @a[scores={open_chest=1..}] run function practice:logger/chest_opened
scoreboard players reset @a open_chest

execute as @a[scores={gold_mined=1..}] run function practice:logger/gold_mined
scoreboard players reset @a gold_mined