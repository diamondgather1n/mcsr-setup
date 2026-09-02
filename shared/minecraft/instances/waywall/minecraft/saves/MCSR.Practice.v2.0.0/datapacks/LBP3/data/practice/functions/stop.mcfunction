schedule clear practice:_start/run_tick
schedule clear practice:_start/wait_for_movement/_standard/wait
schedule clear practice:_start/clear_forceload

difficulty easy

function practice:_start/silent_gamemode/adventure

effect clear @s

effect give @a jump_boost 1 255 true

attribute @s generic.knockback_resistance base set 0

function practice:previous_run_info/save

clear @a

title @s title [{"score":{"name":"minutes","objective":"timer.temp"}},":",{"nbt":"seconds","storage":"timer","interpret":true}]

function timer:stop
function timer:reset
function timer:display/hide

function practice:_start/wait_for_movement/_warp/stop_warping
schedule clear practice:_start/wait_for_movement/_warp/reset_check

scoreboard objectives setdisplay sidebar

scoreboard players set total_barters practice.barters 0
scoreboard players set barter_count current_barter 0

tag @e[type=!#practice:clear_exception_filter] add removal_filter
tag @e[type=area_effect_cloud, tag=spawnpoint] add removal_filter
execute as @e[tag=removal_filter] at @s run tp @s ~ -100 ~
execute as @e[tag=removal_filter] run data merge entity @s {Health:0.0f, DeathLootTable:"minecraft:empty", Silent:1}
kill @e[tag=removal_filter]

function practice:soft_reset
effect give @s saturation 1 20 true

execute as @a in the_nether run tp @s 105 114.5 5 0 2.72

execute as @a at @s run playsound entity.experience_orb.pickup player @s ~ ~ ~ 0.5 1.8

scoreboard players set running bastion.temp 0