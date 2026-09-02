execute if block ~ ~ ~ #practice:air positioned ~ ~1 ~ run function practice:_start/terrain/_flood_bastion/lava_pillar
execute unless block ~ ~ ~ #practice:air run function practice:_start/terrain/_flood_bastion/set_source
execute if block ~ ~ ~ #practice:air if score units_lava settings matches 0 run setblock ~ ~ ~ lava[level=8]