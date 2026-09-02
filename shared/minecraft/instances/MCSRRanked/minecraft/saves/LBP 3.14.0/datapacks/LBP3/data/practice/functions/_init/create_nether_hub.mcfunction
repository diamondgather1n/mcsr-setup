execute in the_nether unless block 100 110 0 white_concrete run setblock 100 110 0 structure_block{ignoreEntities:0b,mode:"LOAD",name:"practice:hub"}
execute in the_nether unless block 100 110 0 white_concrete run setblock 100 111 0 redstone_block

execute in the_nether unless block 100 110 0 white_concrete run schedule function practice:_init/create_nether_hub 1t