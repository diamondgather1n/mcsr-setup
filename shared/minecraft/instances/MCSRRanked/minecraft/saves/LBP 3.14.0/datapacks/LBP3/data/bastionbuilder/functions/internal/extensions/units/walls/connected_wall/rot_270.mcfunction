execute positioned ~6 ~5 ~-8 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~10 ~9 ~-12 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~7 ~14 ~-2 run function bastionbuilder:internal/place/mobs/piglin_melee

execute if score id_piglins bastion.settings matches 1.. positioned ~6 ~5 ~-12 as @e[type=piglin, tag=bastion_mob, dx=4, dy=9, dz=10] run data modify entity @s CustomName set value '{"text":"walls/connected_wall","color":"yellow"}'