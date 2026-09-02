schedule clear practice:_start/wait_for_movement/_warp/reset_check

function practice:_start/silent_gamemode/adventure
execute as @e[tag=bastion_mob] run data merge entity @s {NoAI: 1, Silent:1}

function practice:_start/wait_for_movement/_standard/wait