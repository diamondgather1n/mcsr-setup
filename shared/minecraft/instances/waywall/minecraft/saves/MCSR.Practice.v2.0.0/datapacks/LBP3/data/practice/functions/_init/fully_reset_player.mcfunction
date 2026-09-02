schedule clear practice:_start/run_tick
schedule clear practice:_start/wait_for_movement/_standard/wait
schedule clear practice:_start/clear_forceload

difficulty easy

function practice:_start/silent_gamemode/adventure

effect clear @a

execute as @a run attribute @s generic.knockback_resistance base set 0

clear @a

execute as @a if score editing_loadout practice matches 1 run function practice:signs/loadout_sign/save

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

title @a times 7 15 7

function practice:soft_reset
effect give @a saturation 1 20 true

execute as @a in the_nether run tp @s 105 114.5 5 0 2.72

execute unless entity @a run schedule function practice:_init/fully_reset_player 1t