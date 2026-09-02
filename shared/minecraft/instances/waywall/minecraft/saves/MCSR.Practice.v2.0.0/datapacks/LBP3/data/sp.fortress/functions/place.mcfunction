summon area_effect_cloud ~ ~ ~ {Tags:["fortress_start"]}
execute if score $align_xz sp.fortress matches 1.. as @e[type=area_effect_cloud, tag=fortress_start] run function sp.fortress:internal/align_start_xz

execute as @e[type=area_effect_cloud, tag=fortress_start] at @s run function sp.fortress:internal/place_random

kill @e[type=area_effect_cloud, tag=fortress_start]