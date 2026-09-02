# Create bastion origin marker
kill @e[type=area_effect_cloud, tag=chunk_aligned]
summon area_effect_cloud ~ ~ ~ {Tags:["chunk_aligned"], Duration: 2147483647}

# Align to [0,0] within the current chunk
execute as @e[type=area_effect_cloud, tag=chunk_aligned, limit=1] store result entity @s Pos[0] double 16 run data get entity @s Pos[0] 0.0625
execute as @e[type=area_effect_cloud, tag=chunk_aligned, limit=1] store result entity @s Pos[2] double 16 run data get entity @s Pos[2] 0.0625