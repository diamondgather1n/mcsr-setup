execute positioned ~2 ~25 ~19 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~4 ~25 ~16 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~5 ~25 ~18 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~8 ~25 ~16 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~2 ~26 ~15 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~6 ~26 ~16 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~11 ~26 ~15 run function bastionbuilder:internal/place/mobs/piglin

execute if score id_piglins bastion.settings matches 1.. positioned ~2 ~25 ~15 as @e[type=piglin, tag=bastion_mob, dx=9, dy=1, dz=4] run data modify entity @s CustomName set value '{"text":"starting_pieces/entrance_base","color":"yellow"}'