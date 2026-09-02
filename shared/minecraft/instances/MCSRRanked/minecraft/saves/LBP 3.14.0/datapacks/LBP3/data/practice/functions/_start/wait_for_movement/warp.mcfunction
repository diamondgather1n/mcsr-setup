execute if score tick_warp settings matches 1.. as @e[tag=bastion_mob] run data merge entity @s {NoAI: 0, Silent:0}
execute if score tick_warp settings matches 1.. run title @a actionbar {"text":"Warping...","italic":true,"color":"gray"}
execute if score tick_warp settings matches 1.. run function practice:_start/silent_gamemode/unschedule
execute if score tick_warp settings matches 1.. run function practice:_start/silent_gamemode/creative
execute if score tick_warp settings matches 1.. run function practice:_start/wait_for_movement/_warp/reset_check

execute if score tick_warp settings matches 0 run function practice:_start/wait_for_movement/standard
execute if score tick_warp settings matches 1 run tick warp 600 function practice:_start/wait_for_movement/standard
execute if score tick_warp settings matches 2 run tick warp 1200 function practice:_start/wait_for_movement/standard
execute if score tick_warp settings matches 3 run tick warp 1800 function practice:_start/wait_for_movement/standard
execute if score tick_warp settings matches 4 run tick warp 2400 function practice:_start/wait_for_movement/standard