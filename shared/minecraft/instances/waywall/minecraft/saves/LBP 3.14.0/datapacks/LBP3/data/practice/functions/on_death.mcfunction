schedule clear practice:_start/run_tick
schedule clear practice:_start/wait_for_movement/_standard/wait
schedule clear practice:_start/clear_forceload

difficulty easy

function practice:_start/silent_gamemode/adventure

attribute @s generic.knockback_resistance base set 0

clear @s

execute in the_nether run function practice:previous_run_info/dq

function timer:stop
function timer:reset
function timer:display/hide

scoreboard objectives setdisplay sidebar

scoreboard players set total_barters practice.barters 0
scoreboard players set barter_count current_barter 0

tag @e[type=!#practice:clear_exception_filter] add removal_filter
tag @e[type=area_effect_cloud, tag=spawnpoint] add removal_filter
execute as @e[tag=removal_filter] at @s run tp @s ~ -100 ~
execute as @e[tag=removal_filter] run data merge entity @s {Health:0.0f, DeathLootTable:"minecraft:empty", Silent:1}
kill @e[tag=removal_filter]

execute as @a in the_nether run tp @s 105 114.5 5 0 2.72

team empty no_collison

scoreboard players reset @s deaths

scoreboard players set running bastion.temp 0