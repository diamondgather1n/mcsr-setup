execute if score ui practice matches 1 run title @a actionbar {"text":"Waiting for movement...","italic":true,"color":"gray"}

execute as @a run function practice:_start/movement_detection/check

execute at @a positioned ~ ~ ~ run function practice:_start/terrain/_remove_lava/global
execute at @a positioned ~ ~1 ~ run function practice:_start/terrain/_remove_lava/global
execute as @a if score $moved playerpos matches 1 run function practice:_start/post_generation
execute as @a unless score $moved playerpos matches 1 run schedule function practice:_start/wait_for_movement/_standard/wait 1t

execute as @a[predicate=practice:dropped_pick] at @s run function practice:on_dropped_pick