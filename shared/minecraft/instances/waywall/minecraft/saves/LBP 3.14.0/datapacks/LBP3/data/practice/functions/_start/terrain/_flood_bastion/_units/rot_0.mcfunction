execute if score units_lava settings matches 0 run setblock ~-1 ~-1 ~19 structure_block{mode:"LOAD", name:"practice:lava_housing", rotation:"CLOCKWISE_90", posY:1}
execute if score units_lava settings matches 0 run setblock ~-1 ~-2 ~19 redstone_block
execute if score units_lava settings matches 0 run clone ~-1 ~-2 ~-20 ~-1 ~-1 ~-20 ~-1 ~-2 ~-19

execute unless score units_lava settings matches 2 if score terrain settings matches 1 run setblock ~-3 183 ~19 structure_void
execute unless score units_lava settings matches 2 positioned ~-3 ~48 ~19 run function practice:_start/terrain/_flood_bastion/lava_pillar