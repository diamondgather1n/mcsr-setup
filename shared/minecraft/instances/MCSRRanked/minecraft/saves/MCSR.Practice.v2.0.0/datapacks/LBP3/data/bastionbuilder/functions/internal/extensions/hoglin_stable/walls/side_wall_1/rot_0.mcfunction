execute positioned ~12 ~2 ~7 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~7 ~5 ~8 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~7 ~12 ~4 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~8 ~12 ~5 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~8 ~12 ~6 run function bastionbuilder:internal/place/mobs/piglin

execute if score id_piglins bastion.settings matches 1.. positioned ~7 ~2 ~4 as @e[type=piglin, tag=bastion_mob, dx=5, dy=10, dz=4] run data modify entity @s CustomName set value '{"text":"walls/side_wall_1","color":"yellow"}'