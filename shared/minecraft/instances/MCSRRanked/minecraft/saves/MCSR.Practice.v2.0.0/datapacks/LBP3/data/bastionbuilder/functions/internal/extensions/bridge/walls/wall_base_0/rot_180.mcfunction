execute positioned ~-5 ~2 ~-12 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-5 ~4 ~-8 run function bastionbuilder:internal/place/mobs/piglin

execute if score id_piglins bastion.settings matches 1.. positioned ~-5 ~2 ~-12 as @e[type=piglin, tag=bastion_mob, dx=0, dy=2, dz=4] run data modify entity @s CustomName set value '{"text":"walls/wall_base_0","color":"yellow"}'