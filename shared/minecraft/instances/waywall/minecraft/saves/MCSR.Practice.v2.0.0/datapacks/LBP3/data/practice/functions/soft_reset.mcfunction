# Extinguish fire
execute if entity @a[gamemode=survival] run schedule function practice:_start/silent_gamemode/survival 3t
execute if entity @a[gamemode=adventure] run schedule function practice:_start/silent_gamemode/adventure 3t
function practice:_start/silent_gamemode/creative

# Reset health
effect give @a instant_health 1 4 true

# Reset hunger and saturation
execute if score sat_reset practice matches 0 run effect give @a saturation 1 20 true
execute if score sat_reset practice matches 1.. if score has_carpet practice matches 1 as @a run function practice:_soft_reset/hunger