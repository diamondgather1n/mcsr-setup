execute positioned ~12 ~2 ~-5 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~8 ~4 ~-5 run function bastionbuilder:internal/place/mobs/piglin

execute if score id_piglins bastion.settings matches 1.. positioned ~8 ~2 ~-5 as @e[type=piglin, tag=bastion_mob, dx=4, dy=2, dz=0] run data modify entity @s CustomName set value '{"text":"walls/wall_base_0","color":"yellow"}'