execute if score units_lava settings matches 0 run setblock ~-19 ~-1 ~-1 structure_block{mode:"LOAD", name:"practice:lava_housing", rotation:"CLOCKWISE_180", posY:1}
execute if score units_lava settings matches 0 run setblock ~-19 ~-2 ~-1 redstone_block
execute if score units_lava settings matches 0 run clone ~-20 ~-2 ~-1 ~-20 ~-1 ~-1 ~-19 ~-2 ~-1

execute unless score units_lava settings matches 2 if score terrain settings matches 1 run setblock ~-19 183 ~-3 structure_void
execute unless score units_lava settings matches 2 positioned ~-19 ~48 ~-3 run function practice:_start/terrain/_flood_bastion/lava_pillar