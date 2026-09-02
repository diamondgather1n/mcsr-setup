scoreboard players add @p pearlCount 1
execute if score @p pearlCount matches 1 run schedule function practice:movement/pearl_start 10t
execute if score @p pearlCount matches 1 run schedule function practice:movement/bridge_finish 10t