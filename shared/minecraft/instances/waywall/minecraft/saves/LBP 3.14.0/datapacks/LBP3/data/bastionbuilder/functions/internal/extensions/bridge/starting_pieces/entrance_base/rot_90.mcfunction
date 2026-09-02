execute positioned ~-19 ~25 ~2 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-16 ~25 ~4 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-18 ~25 ~5 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-16 ~25 ~8 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-15 ~26 ~2 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-16 ~26 ~6 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-15 ~26 ~11 run function bastionbuilder:internal/place/mobs/piglin

execute if score id_piglins bastion.settings matches 1.. positioned ~-19 ~25 ~2 as @e[type=piglin, tag=bastion_mob, dx=4, dy=1, dz=9] run data modify entity @s CustomName set value '{"text":"starting_pieces/entrance_base","color":"yellow"}'