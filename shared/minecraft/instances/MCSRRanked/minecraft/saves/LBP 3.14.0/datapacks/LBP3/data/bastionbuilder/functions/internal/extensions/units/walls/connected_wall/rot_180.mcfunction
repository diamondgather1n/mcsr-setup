execute positioned ~-8 ~5 ~-6 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-12 ~9 ~-10 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-2 ~14 ~-7 run function bastionbuilder:internal/place/mobs/piglin_melee

execute if score id_piglins bastion.settings matches 1.. positioned ~-12 ~5 ~-10 as @e[type=piglin, tag=bastion_mob, dx=10, dy=9, dz=4] run data modify entity @s CustomName set value '{"text":"walls/connected_wall","color":"yellow"}'